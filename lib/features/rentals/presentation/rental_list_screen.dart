import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_theme.dart';
import '../../parking_map/presentation/parking_map_controller.dart';
import '../domain/rental_transaction.dart';

class RentalListScreen extends ConsumerStatefulWidget {
  const RentalListScreen({super.key});

  @override
  ConsumerState<RentalListScreen> createState() => _RentalListScreenState();
}

class _RentalListScreenState extends ConsumerState<RentalListScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<RentalTransaction> _filterRentals(List<RentalTransaction> rentals) {
    if (_searchQuery.isEmpty) return rentals;
    return rentals
        .where((r) => r.licensePlate.contains(_searchQuery.toUpperCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final activeRentalsAsync = ref.watch(activeRentalsProvider);
    final historyAsync = ref.watch(rentalHistoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rentas e Historial'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.primary,
          labelColor: AppTheme.primary,
          unselectedLabelColor: AppTheme.textSecondary,
          tabs: const [
            Tab(text: 'Activas (Caja Abierta)', icon: Icon(Icons.directions_car_rounded)),
            Tab(text: 'Historial Completo', icon: Icon(Icons.receipt_long_rounded)),
          ],
        ),
      ),
      body: Column(
        children: [
          // Elegant Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Buscar por placa del vehículo',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
              ),
              onChanged: (val) {
                setState(() {
                  _searchQuery = val;
                });
              },
            ),
          ),

          // Main Tab Views
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // 1. Tab active rentals
                activeRentalsAsync.when(
                  data: (rentals) {
                    final filtered = _filterRentals(rentals);
                    if (filtered.isEmpty) {
                      return _buildEmptyState(
                        icon: Icons.check_circle_outline_rounded,
                        message: _searchQuery.isEmpty
                            ? 'No hay ninguna renta activa.'
                            : 'Ningún vehículo activo coincide con "$_searchQuery".',
                      );
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: filtered.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 12),
                      itemBuilder: (context, index) => _buildRentalCard(context, filtered[index], isActive: true),
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (err, _) => Center(child: Text('Error: $err')),
                ),

                // 2. Tab history rentals
                historyAsync.when(
                  data: (rentals) {
                    final filtered = _filterRentals(rentals);
                    if (filtered.isEmpty) {
                      return _buildEmptyState(
                        icon: Icons.history_toggle_off_rounded,
                        message: _searchQuery.isEmpty
                            ? 'El historial de rentas está vacío.'
                            : 'Ninguna transacción del historial coincide con "$_searchQuery".',
                      );
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: filtered.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 12),
                      itemBuilder: (context, index) => _buildRentalCard(context, filtered[index], isActive: false),
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (err, _) => Center(child: Text('Error: $err')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRentalCard(BuildContext context, RentalTransaction rental, {required bool isActive}) {
    final formatter = DateFormat('dd MMM yyyy, hh:mm a');
    final duration = (rental.checkOutTime ?? DateTime.now()).difference(rental.checkInTime);
    final hours = duration.inMinutes / 60.0;
    
    final finalCost = isActive ? rental.calculateCurrentAmount() : rental.totalAmount ?? 0.0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Lote ${rental.slotLabel}',
                        style: const TextStyle(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      rental.licensePlate,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: (isActive ? AppTheme.occupied : AppTheme.available).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    isActive ? 'Activo' : 'Pagado',
                    style: TextStyle(
                      color: isActive ? AppTheme.occupied : AppTheme.available,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 24, color: Color(0xFF334155)),

            // Timing details
            Row(
              children: [
                const Icon(Icons.login_rounded, size: 16, color: AppTheme.textSecondary),
                const SizedBox(width: 8),
                Text(
                  'Entrada: ${formatter.format(rental.checkInTime)}',
                  style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13),
                ),
              ],
            ),
            if (!isActive && rental.checkOutTime != null) ...[
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.logout_rounded, size: 16, color: AppTheme.textSecondary),
                  const SizedBox(width: 8),
                  Text(
                    'Salida: ${formatter.format(rental.checkOutTime!)}',
                    style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.timer_outlined, size: 16, color: AppTheme.textSecondary),
                const SizedBox(width: 8),
                Text(
                  'Duración: ${hours.toStringAsFixed(1)} horas',
                  style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13),
                ),
              ],
            ),
            
            if (rental.vehicleDetails != null && rental.vehicleDetails!.isNotEmpty) ...[
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.info_outline_rounded, size: 16, color: AppTheme.textSecondary),
                  const SizedBox(width: 8),
                  Text(
                    'Vehículo: ${rental.vehicleDetails}',
                    style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13),
                  ),
                ],
              ),
            ],

            const Divider(height: 24, color: Color(0xFF334155)),

            // Rates and costs
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tarifa: \$${rental.hourlyRate.toStringAsFixed(2)} / hr',
                  style: const TextStyle(color: AppTheme.textMuted, fontSize: 13),
                ),
                Row(
                  children: [
                    Text(
                      isActive ? 'Acumulado: ' : 'Total Cobrado: ',
                      style: const TextStyle(color: AppTheme.textSecondary, fontSize: 14),
                    ),
                    Text(
                      '\$${finalCost.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: AppTheme.available,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState({required IconData icon, required String message}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 64, color: AppTheme.textMuted),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppTheme.textSecondary, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
