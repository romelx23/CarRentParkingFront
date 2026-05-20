import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_theme.dart';
import '../../parking_map/domain/parking_slot.dart';
import '../../parking_map/presentation/parking_map_controller.dart';
import '../../rentals/domain/rental_transaction.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final slotsAsync = ref.watch(parkingSlotsProvider);
    final activeRentalsAsync = ref.watch(activeRentalsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CartRent Parking'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/settings'),
          ),
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: () => context.go('/login'),
          ),
        ],
      ),
      body: slotsAsync.when(
        data: (slots) {
          final totalSlots = slots.length;
          final occupiedSlots = slots.where((s) => s.status == SlotStatus.occupied).length;
          final reservedSlots = slots.where((s) => s.status == SlotStatus.reserved).length;
          final availableSlots = slots.where((s) => s.status == SlotStatus.available).length;
          
          final occupancyRate = totalSlots > 0 ? (occupiedSlots / totalSlots) : 0.0;

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(parkingSlotsProvider);
              ref.invalidate(activeRentalsProvider);
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Greeting & Header
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '¡Hola, Operador!',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          Text(
                            'Estado del estacionamiento en tiempo real',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Hero Occupancy Card
                  _buildHeroCard(context, totalSlots, occupiedSlots, occupancyRate),
                  const SizedBox(height: 24),

                  // Mini Stats Grid
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.5,
                    children: [
                      _buildMiniStatCard(
                        context,
                        title: 'Disponibles',
                        value: '$availableSlots',
                        icon: Icons.check_circle_outline_rounded,
                        color: AppTheme.available,
                      ),
                      _buildMiniStatCard(
                        context,
                        title: 'Reservados',
                        value: '$reservedSlots',
                        icon: Icons.hourglass_empty_rounded,
                        color: AppTheme.reserved,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Modules Grid Navigation
                  const Text(
                    'Accesos Directos',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildQuickAccessMenu(context),
                  const SizedBox(height: 24),

                  // Active Rentals List Preview
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Rentas Activas',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      TextButton(
                        onPressed: () => context.push('/rentals'),
                        child: const Text('Ver todas'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  activeRentalsAsync.when(
                    data: (activeRentals) {
                      if (activeRentals.isEmpty) {
                        return _buildEmptyStateCard(
                          icon: Icons.directions_car_filled_outlined,
                          message: 'No hay rentas activas en este momento.',
                        );
                      }
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: activeRentals.length > 5 ? 5 : activeRentals.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final rental = activeRentals[index];
                          return _buildRentalListItem(context, rental);
                        },
                      );
                    },
                    loading: () => const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    error: (err, _) => Text('Error: $err'),
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline_rounded, size: 48, color: AppTheme.occupied),
              const SizedBox(height: 16),
              Text('Error al cargar datos: $err'),
              ElevatedButton(
                onPressed: () => ref.invalidate(parkingSlotsProvider),
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroCard(BuildContext context, int total, int occupied, double occupancyRate) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Capacidad total',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                Text(
                  '$occupied / $total Lotes',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '${(occupancyRate * 100).toStringAsFixed(1)}% de ocupación actual',
                  style: const TextStyle(
                    color: Colors.white70, // Slightly translucent white
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 74,
                height: 74,
                child: CircularProgressIndicator(
                  value: occupancyRate,
                  strokeWidth: 8,
                  backgroundColor: Colors.white24,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              Text(
                '${(occupancyRate * 100).round()}%',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.textSecondary,
                  ),
                ),
                Icon(icon, size: 20, color: color),
              ],
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAccessMenu(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.6,
      children: [
        _buildMenuButton(
          context,
          label: 'Ver Mapa 2D',
          subtitle: 'Tiempo Real',
          icon: Icons.map_rounded,
          color: AppTheme.primary,
          onTap: () => context.push('/map'),
        ),
        _buildMenuButton(
          context,
          label: 'Editor de Mapa',
          subtitle: 'Configura Lotes',
          icon: Icons.edit_road_rounded,
          color: AppTheme.accent,
          onTap: () => context.push('/editor'),
        ),
        _buildMenuButton(
          context,
          label: 'Rentas',
          subtitle: 'Historial / Caja',
          icon: Icons.history_rounded,
          color: AppTheme.reserved,
          onTap: () => context.push('/rentals'),
        ),
        _buildMenuButton(
          context,
          label: 'Ajustes',
          subtitle: 'Tarifas y Base',
          icon: Icons.tune_rounded,
          color: AppTheme.textMuted,
          onTap: () => context.push('/settings'),
        ),
      ],
    );
  }

  Widget _buildMenuButton(
    BuildContext context, {
    required String label,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              const Spacer(),
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppTheme.textPrimary,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRentalListItem(BuildContext context, RentalTransaction rental) {
    final activeHours = DateTime.now().difference(rental.checkInTime).inMinutes / 60.0;
    final currentCost = rental.calculateCurrentAmount();

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppTheme.occupied.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.directions_car_rounded, color: AppTheme.occupied),
        ),
        title: Row(
          children: [
            Text(
              rental.licensePlate,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppTheme.primary.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Lote ${rental.slotLabel}',
                style: const TextStyle(color: AppTheme.primary, fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              'Entrada: ${DateFormat('dd MMM - hh:mm a').format(rental.checkInTime)}',
              style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
            ),
            Text(
              'Tiempo transcurrido: ${activeHours.toStringAsFixed(1)} hrs',
              style: const TextStyle(fontSize: 11, color: AppTheme.textMuted),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '\$${currentCost.toStringAsFixed(2)}',
              style: const TextStyle(
                color: AppTheme.available,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const Text(
              'Por pagar',
              style: TextStyle(
                color: AppTheme.textMuted,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyStateCard({required IconData icon, required String message}) {
    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: AppTheme.textMuted),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
