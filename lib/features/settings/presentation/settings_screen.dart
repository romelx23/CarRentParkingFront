import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../parking_map/presentation/parking_map_controller.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapState = ref.watch(parkingMapControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración e Info'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Database Operations Section
            const Text(
              'Base de Datos y Datos de Prueba',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Semillero del Estacionamiento',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Esta acción eliminará todos los lotes actuales y generará una distribución estética prediseñada con 16 lotes en dos hileras principales, vías de tránsito dibujadas en 2D y celdas listas para operar.',
                      style: TextStyle(color: AppTheme.textSecondary, fontSize: 13),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: mapState.isLoading
                          ? null
                          : () async {
                              await ref.read(parkingMapControllerProvider.notifier).seedDemoData();
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Estructura demo cargada con éxito.'),
                                    backgroundColor: AppTheme.available,
                                  ),
                                );
                              }
                            },
                      icon: mapState.isLoading
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                            )
                          : const Icon(Icons.layers_clear_rounded),
                      label: Text(mapState.isLoading ? 'Generando...' : 'Restablecer y Cargar Estructura Demo'),
                      style: ElevatedButton.styleFrom(backgroundColor: AppTheme.accent),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // 2. Info Packages Section
            const Text(
              'Arquitectura del Ecosistema',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
            ),
            const SizedBox(height: 12),
            
            // Frontend Packages Card
            _buildTechCard(
              title: 'Frontend (Flutter App)',
              color: AppTheme.primary,
              icon: Icons.flutter_dash_rounded,
              description: 'Paquetes de Flutter instalados y configurados para alta reactividad, control gráfico 2D e inyección de dependencias:',
              packages: [
                'flutter_riverpod: Gestión de estado reactiva moderna, desacoplada y fácilmente testeable.',
                'drift & sqlite3_flutter_libs: Base de datos local SQLite robusta con streams en tiempo real de consultas tipadas.',
                'go_router: Enrutador oficial declarativo con rutas tipadas y sub-rutas.',
                'dio: Cliente HTTP robusto con interceptores para comunicación con la API.',
                'web_socket_channel: Conectores a WebSockets del backend para updates en tiempo real.',
                'google_fonts: Acceso dinámico a Outfit/Inter para una tipografía premium.',
              ],
            ),
            const SizedBox(height: 20),

            // Backend Packages Card
            _buildTechCard(
              title: 'Backend (Ecosistema Propuesto)',
              color: AppTheme.accent,
              icon: Icons.dns_rounded,
              description: 'Paquetes recomendados para el servidor conectado de forma remota a PostgreSQL:',
              packages: [
                'express / fastify: Frameworks web minimalistas en Node.js para endpoints REST rápidos.',
                'prisma: ORM tipado para TypeScript para realizar consultas limpias y migraciones en Postgres.',
                'socket.io / ws: Servidor WebSockets para transmitir el estado de los lotes en tiempo real.',
                'ts-node-dev: Compilación y recarga en caliente instantánea durante el desarrollo.',
                'pg: Controlador PostgreSQL de alto rendimiento.',
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildTechCard({
    required String title,
    required Color color,
    required IconData icon,
    required String description,
    required List<String> packages,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(description, style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
            const SizedBox(height: 12),
            const Divider(color: Color(0xFF334155)),
            const SizedBox(height: 12),
            ...packages.map((pkg) {
              final parts = pkg.split(':');
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.arrow_right_rounded, color: AppTheme.textMuted, size: 20),
                    const SizedBox(width: 4),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(fontSize: 13, height: 1.4, color: AppTheme.textSecondary),
                          children: [
                            TextSpan(
                              text: '${parts[0]}:',
                              style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
                            ),
                            TextSpan(text: parts.length > 1 ? parts[1] : ''),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
