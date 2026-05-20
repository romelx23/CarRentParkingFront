import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_theme.dart';
import '../domain/parking_slot.dart';
import '../../rentals/domain/rental_transaction.dart';
import 'parking_map_controller.dart';
import 'parking_map_painter.dart';

class ParkingMapScreen extends ConsumerStatefulWidget {
  const ParkingMapScreen({super.key});

  @override
  ConsumerState<ParkingMapScreen> createState() => _ParkingMapScreenState();
}

class _ParkingMapScreenState extends ConsumerState<ParkingMapScreen> {
  final TransformationController _transformationController = TransformationController();
  ParkingSlot? _selectedSlot;

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  void _showSlotDetails(ParkingSlot slot, List<RentalTransaction> activeRentals) {
    setState(() {
      _selectedSlot = slot;
    });

    RentalTransaction? currentRental;
    if (slot.activeRentalId != null) {
      currentRental = activeRentals.cast<RentalTransaction?>().firstWhere(
        (r) => r?.id == slot.activeRentalId,
        orElse: () => null,
      );
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return _buildBottomSheetDetails(slot, currentRental);
      },
    ).then((_) {
      setState(() {
        _selectedSlot = null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final slotsAsync = ref.watch(parkingSlotsProvider);
    final activeRentalsAsync = ref.watch(activeRentalsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa en Tiempo Real'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_road_rounded, color: AppTheme.primary),
            tooltip: 'Modo Edición',
            onPressed: () => context.push('/editor'),
          ),
        ],
      ),
      body: slotsAsync.when(
        data: (slots) {
          return activeRentalsAsync.when(
            data: (activeRentals) {
              return Stack(
                children: [
                  // Interactive 2D Canvas Area
                  InteractiveViewer(
                    transformationController: _transformationController,
                    minScale: 0.2,
                    maxScale: 3.0,
                    boundaryMargin: const EdgeInsets.all(500),
                    child: Center(
                      child: Container(
                        width: 1200,
                        height: 900,
                        decoration: BoxDecoration(
                          color: AppTheme.background,
                          border: Border.all(
                            color: const Color(0xFF1E293B),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 30,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            // Background roads and labels Custom Paint
                            Positioned.fill(
                              child: CustomPaint(
                                painter: ParkingMapPainter(
                                  slots: slots,
                                  selectedSlot: _selectedSlot,
                                  isEditMode: false,
                                ),
                              ),
                            ),

                            // Positioned interactive slots
                            ...slots.map((slot) {
                              return Positioned(
                                left: slot.x,
                                top: slot.y,
                                width: slot.width,
                                height: slot.height,
                                child: Transform.rotate(
                                  angle: slot.rotation,
                                  child: GestureDetector(
                                    onTap: () => _showSlotDetails(slot, activeRentals),
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: _buildSlotUI(slot),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Overlay Float Legend
                  Positioned(
                    top: 16,
                    left: 16,
                    right: 16,
                    child: _buildLegendPanel(),
                  ),

                  // Overlay instructions
                  Positioned(
                    bottom: 24,
                    right: 24,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        _transformationController.value = Matrix4.identity();
                      },
                      icon: const Icon(Icons.center_focus_strong_rounded),
                      label: const Text('Centrar Vista'),
                      backgroundColor: AppTheme.surface,
                      foregroundColor: AppTheme.textPrimary,
                    ),
                  ),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => Center(child: Text('Error rentals: $err')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error slots: $err')),
      ),
    );
  }

  Widget _buildSlotUI(ParkingSlot slot) {
    final isSelected = _selectedSlot?.id == slot.id;
    Color statusColor;
    IconData? slotIcon;

    switch (slot.status) {
      case SlotStatus.available:
        statusColor = AppTheme.available;
      case SlotStatus.occupied:
        statusColor = AppTheme.occupied;
        slotIcon = Icons.directions_car_filled_rounded;
      case SlotStatus.reserved:
        statusColor = AppTheme.reserved;
        slotIcon = Icons.access_time_filled_rounded;
    }

    if (slot.type == SlotType.disabled) {
      slotIcon = Icons.accessible_forward_rounded;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: isSelected
            ? AppTheme.primary.withOpacity(0.2)
            : statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? AppTheme.primary : statusColor.withOpacity(0.8),
          width: isSelected ? 3.0 : 1.5,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (slotIcon != null)
              Icon(
                slotIcon,
                size: math.min(slot.width, slot.height) * 0.35,
                color: isSelected ? AppTheme.primary : statusColor,
              ),
            const SizedBox(height: 4),
            Text(
              slot.label,
              style: TextStyle(
                color: isSelected ? AppTheme.textPrimary : const Color(0xFFE2E8F0),
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendPanel() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.surface.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF334155), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _LegendItem(color: AppTheme.available, label: 'Disponible'),
          _LegendItem(color: AppTheme.occupied, label: 'Ocupado'),
          _LegendItem(color: AppTheme.reserved, label: 'Reservado'),
        ],
      ),
    );
  }

  Widget _buildBottomSheetDetails(ParkingSlot slot, RentalTransaction? rental) {
    final isOccupied = slot.status == SlotStatus.occupied;
    final defaultPrice = slot.hourlyRate ?? 10.0;

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF334155), width: 1.5),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 48,
              height: 5,
              decoration: BoxDecoration(
                color: AppTheme.textMuted.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Title Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lote ${slot.label}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  Text(
                    'Tipo: ${slot.type == SlotType.disabled ? "Discapacitado" : slot.type == SlotType.large ? "Grande" : "Estándar"}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: (isOccupied ? AppTheme.occupied : AppTheme.available).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  isOccupied ? 'Ocupado' : 'Disponible',
                  style: TextStyle(
                    color: isOccupied ? AppTheme.occupied : AppTheme.available,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 32, color: Color(0xFF334155)),

          if (isOccupied && rental != null) ...[
            // Active Rental Summary details
            _buildDetailRow('Vehículo / Placa', rental.licensePlate, icon: Icons.badge_rounded),
            _buildDetailRow('Detalles del Vehículo', rental.vehicleDetails ?? 'Sin registrar', icon: Icons.directions_car_rounded),
            _buildDetailRow('Contacto Cliente', rental.customerPhone ?? 'Sin registrar', icon: Icons.phone_rounded),
            _buildDetailRow('Hora Entrada', DateFormat('hh:mm a (dd/MM)').format(rental.checkInTime), icon: Icons.login_rounded),
            _buildDetailRow(
              'Tiempo Transcurrido',
              '${(DateTime.now().difference(rental.checkInTime).inMinutes / 60.0).toStringAsFixed(1)} hrs',
              icon: Icons.hourglass_top_rounded,
            ),
            _buildDetailRow(
              'Tarifa',
              '\$${rental.hourlyRate.toStringAsFixed(2)} / hora',
              icon: Icons.payments_rounded,
            ),
            const Divider(height: 32, color: Color(0xFF334155)),
            
            // Total calculated price box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.available.withOpacity(0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.available.withOpacity(0.2)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Costo Acumulado',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  Text(
                    '\$${rental.calculateCurrentAmount().toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: AppTheme.available,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Checkout action button
            ElevatedButton(
              onPressed: () async {
                final completed = await ref.read(parkingMapControllerProvider.notifier).checkOut(slot.id);
                if (mounted) {
                  Navigator.pop(context);
                  if (completed != null) {
                    _showReceiptDialog(context, completed);
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.occupied,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Liberar Lote y Procesar Cobro'),
            ),
          ] else ...[
            // Slot is Free -> Show Check-in Rent fields Form
            _buildCheckInForm(slot, defaultPrice),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppTheme.textSecondary),
          const SizedBox(width: 12),
          Text(
            '$label:',
            style: const TextStyle(color: AppTheme.textSecondary, fontSize: 14),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckInForm(ParkingSlot slot, double defaultPrice) {
    final formKey = GlobalKey<FormState>();
    final plateController = TextEditingController();
    final vehicleController = TextEditingController();
    final phoneController = TextEditingController();
    final priceController = TextEditingController(text: defaultPrice.toStringAsFixed(1));

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: plateController,
            textCapitalization: TextCapitalization.characters,
            decoration: const InputDecoration(
              labelText: 'Placa del Vehículo',
              prefixIcon: Icon(Icons.badge_rounded),
              hintText: 'Ej: AB-1234',
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Requerido';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: vehicleController,
            decoration: const InputDecoration(
              labelText: 'Detalles (Marca, Color, Modelo)',
              prefixIcon: Icon(Icons.directions_car_rounded),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Teléfono Cliente',
                    prefixIcon: Icon(Icons.phone_rounded),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 1,
                child: TextFormField(
                  controller: priceController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: '\$/Hora',
                    prefixIcon: Icon(Icons.payments_rounded),
                  ),
                  validator: (value) {
                    if (value == null || double.tryParse(value) == null) {
                      return 'Inválido';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                await ref.read(parkingMapControllerProvider.notifier).checkIn(
                      slotId: slot.id,
                      slotLabel: slot.label,
                      licensePlate: plateController.text.toUpperCase().trim(),
                      vehicleDetails: vehicleController.text.trim(),
                      customerPhone: phoneController.text.trim(),
                      hourlyRate: double.parse(priceController.text),
                    );
                if (mounted) {
                  Navigator.pop(context);
                }
              }
            },
            child: const Text('Registrar Entrada'),
          ),
        ],
      ),
    );
  }

  void _showReceiptDialog(BuildContext context, RentalTransaction completed) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppTheme.surface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Row(
            children: [
              Icon(Icons.check_circle_rounded, color: AppTheme.available),
              SizedBox(width: 8),
              Text('Renta Finalizada'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Lote: ${completed.slotLabel}', style: const TextStyle(fontWeight: FontWeight.bold)),
              Text('Placa: ${completed.licensePlate}'),
              const SizedBox(height: 8),
              Text('Entrada: ${DateFormat('hh:mm a').format(completed.checkInTime)}'),
              Text('Salida: ${DateFormat('hh:mm a').format(completed.checkOutTime!)}'),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total a pagar:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    '\$${completed.totalAmount!.toStringAsFixed(2)}',
                    style: const TextStyle(color: AppTheme.available, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.5),
                blurRadius: 4,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppTheme.textPrimary),
        ),
      ],
    );
  }
}
