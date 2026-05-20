import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../domain/parking_slot.dart';
import 'parking_map_controller.dart';
import 'parking_map_painter.dart';

class MapEditorScreen extends ConsumerStatefulWidget {
  const MapEditorScreen({super.key});

  @override
  ConsumerState<MapEditorScreen> createState() => _MapEditorScreenState();
}

class _MapEditorScreenState extends ConsumerState<MapEditorScreen> {
  final TransformationController _transformationController = TransformationController();
  List<ParkingSlot> _editedSlots = [];
  ParkingSlot? _selectedSlot;
  bool _isDraggingSlot = false;
  bool _snapToGrid = true;
  final double _gridSize = 20.0;
  bool _isInitialized = false;

  // Form controllers
  final _labelController = TextEditingController();

  @override
  void dispose() {
    _transformationController.dispose();
    _labelController.dispose();
    super.dispose();
  }

  void _initializeSlots(List<ParkingSlot> dbSlots) {
    if (!_isInitialized) {
      _editedSlots = List.from(dbSlots);
      _isInitialized = true;
    }
  }

  void _selectSlot(ParkingSlot slot) {
    setState(() {
      _selectedSlot = slot;
      _labelController.text = slot.label;
    });
  }

  void _addNewSlot() {
    final nextNumber = _editedSlots.length + 1;
    final newSlot = ParkingSlot(
      id: UniqueKey().toString(), // temporary uuid
      label: 'L-$nextNumber',
      x: 100.0,
      y: 100.0,
      width: 70.0,
      height: 120.0,
      rotation: 0.0,
      status: SlotStatus.available,
      type: SlotType.standard,
    );

    setState(() {
      _editedSlots.add(newSlot);
      _selectSlot(newSlot);
    });
  }

  void _deleteSelectedSlot() {
    if (_selectedSlot == null) return;
    setState(() {
      _editedSlots.removeWhere((s) => s.id == _selectedSlot!.id);
      _selectedSlot = null;
    });
  }

  void _updateSelectedSlotRotation(double deltaRadians) {
    if (_selectedSlot == null) return;
    final updated = _selectedSlot!.copyWith(
      rotation: (_selectedSlot!.rotation + deltaRadians) % (2 * math.pi),
    );
    _updateSlotInList(updated);
  }

  void _updateSlotInList(ParkingSlot updated) {
    setState(() {
      final index = _editedSlots.indexWhere((s) => s.id == updated.id);
      if (index != -1) {
        _editedSlots[index] = updated;
        _selectedSlot = updated;
      }
    });
  }

  double _snap(double value) {
    if (!_snapToGrid) return value;
    return (value / _gridSize).round() * _gridSize;
  }

  Future<void> _saveAllChanges() async {
    await ref.read(parkingMapControllerProvider.notifier).saveEditedSlots(_editedSlots);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mapa y lotes guardados correctamente.'),
          backgroundColor: AppTheme.available,
        ),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final slotsAsync = ref.watch(parkingSlotsProvider);

    // Initialize list from db if not done yet
    slotsAsync.whenData((dbSlots) => _initializeSlots(dbSlots));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Diseñador de Estacionamientos'),
        actions: [
          Row(
            children: [
              const Text('Ajustar a red', style: TextStyle(fontSize: 12)),
              Switch(
                value: _snapToGrid,
                activeColor: AppTheme.primary,
                onChanged: (val) {
                  setState(() {
                    _snapToGrid = val;
                  });
                },
              ),
            ],
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.check_rounded, color: AppTheme.available),
            tooltip: 'Guardar todo',
            onPressed: _saveAllChanges,
          ),
        ],
      ),
      body: Row(
        children: [
          // Main Editor Drawing Area
          Expanded(
            child: slotsAsync.when(
              data: (dbSlots) {
                return Stack(
                  children: [
                    // Canvas area inside panning controller
                    InteractiveViewer(
                      transformationController: _transformationController,
                      minScale: 0.2,
                      maxScale: 3.0,
                      panEnabled: !_isDraggingSlot, // Lock pan during lot drags
                      boundaryMargin: const EdgeInsets.all(400),
                      child: Center(
                        child: Container(
                          width: 1200,
                          height: 900,
                          decoration: BoxDecoration(
                            color: AppTheme.background,
                            border: Border.all(
                              color: AppTheme.primary.withOpacity(0.3),
                              width: 2,
                            ),
                          ),
                          child: Stack(
                            children: [
                              // Grid custom painter
                              Positioned.fill(
                                child: CustomPaint(
                                  painter: ParkingMapPainter(
                                    slots: _editedSlots,
                                    selectedSlot: _selectedSlot,
                                    isEditMode: true,
                                    gridSnapSize: _gridSize,
                                  ),
                                ),
                              ),

                              // Positioned draggable slot widget layers
                              ..._editedSlots.map((slot) {
                                final isSelected = _selectedSlot?.id == slot.id;
                                return Positioned(
                                  left: slot.x,
                                  top: slot.y,
                                  width: slot.width,
                                  height: slot.height,
                                  child: Transform.rotate(
                                    angle: slot.rotation,
                                    child: GestureDetector(
                                      onTap: () => _selectSlot(slot),
                                      onPanStart: (_) {
                                        setState(() {
                                          _isDraggingSlot = true;
                                          _selectSlot(slot);
                                        });
                                      },
                                      onPanUpdate: (details) {
                                        // Calculate viewport translation based on viewer transformation scale
                                        final scale = _transformationController.value.getMaxScaleOnAxis();
                                        final newX = _snap(slot.x + details.delta.dx / scale);
                                        final newY = _snap(slot.y + details.delta.dy / scale);
                                        
                                        _updateSlotInList(
                                          slot.copyWith(x: newX, y: newY),
                                        );
                                      },
                                      onPanEnd: (_) {
                                        setState(() {
                                          _isDraggingSlot = false;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: isSelected 
                                              ? AppTheme.primary.withOpacity(0.1) 
                                              : Colors.transparent,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
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

                    // Top Action Float Bar
                    Positioned(
                      top: 16,
                      left: 16,
                      child: FloatingActionButton.extended(
                        onPressed: _addNewSlot,
                        icon: const Icon(Icons.add_location_alt_rounded),
                        label: const Text('Agregar Lote'),
                        backgroundColor: AppTheme.primary,
                      ),
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('Error: $err')),
            ),
          ),

          // Properties Sidebar panel
          _buildSidebarEditor(),
        ],
      ),
    );
  }

  Widget _buildSidebarEditor() {
    if (_selectedSlot == null) {
      return Container(
        width: 300,
        decoration: const BoxDecoration(
          color: AppTheme.surface,
          border: Border(left: BorderSide(color: Color(0xFF334155))),
        ),
        padding: const EdgeInsets.all(24),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.touch_app_rounded, size: 48, color: AppTheme.textMuted),
              SizedBox(height: 16),
              Text(
                'Selecciona un lote en el mapa para configurar sus propiedades.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppTheme.textSecondary),
              ),
            ],
          ),
        ),
      );
    }

    final slot = _selectedSlot!;

    return Container(
      width: 300,
      decoration: const BoxDecoration(
        color: AppTheme.surface,
        border: Border(left: BorderSide(color: Color(0xFF334155))),
      ),
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Configurar Lote',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 24, color: Color(0xFF334155)),

            // Label text field
            const Text('Identificador', style: TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
            const SizedBox(height: 8),
            TextFormField(
              controller: _labelController,
              decoration: const InputDecoration(hintText: 'Ej: A-01'),
              onChanged: (val) {
                _updateSlotInList(slot.copyWith(label: val));
              },
            ),
            const SizedBox(height: 20),

            // Slot Type Dropdown
            const Text('Tipo de Lote', style: TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
            const SizedBox(height: 8),
            DropdownButtonFormField<SlotType>(
              value: slot.type,
              decoration: const InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 16)),
              items: SlotType.values.map((t) {
                return DropdownMenuItem(
                  value: t,
                  child: Text(t == SlotType.disabled ? 'Discapacitado' : t == SlotType.large ? 'Grande' : 'Estándar'),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  _updateSlotInList(slot.copyWith(type: val));
                }
              },
            ),
            const SizedBox(height: 20),

            // Dimension adjusters
            const Text('Dimensiones (Ancho x Alto)', style: TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Text('Ancho', style: TextStyle(fontSize: 11, color: AppTheme.textMuted)),
                      Slider(
                        value: slot.width,
                        min: 40.0,
                        max: 150.0,
                        activeColor: AppTheme.primary,
                        onChanged: (val) {
                          _updateSlotInList(slot.copyWith(width: _snap(val)));
                        },
                      ),
                      Text('${slot.width.round()} px', style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Text('Alto', style: TextStyle(fontSize: 11, color: AppTheme.textMuted)),
                      Slider(
                        value: slot.height,
                        min: 60.0,
                        max: 200.0,
                        activeColor: AppTheme.primary,
                        onChanged: (val) {
                          _updateSlotInList(slot.copyWith(height: _snap(val)));
                        },
                      ),
                      Text('${slot.height.round()} px', style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Rotation
            const Text('Rotación', style: TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton.filledTonal(
                  icon: const Icon(Icons.rotate_left_rounded),
                  tooltip: '-15°',
                  onPressed: () => _updateSelectedSlotRotation(-15 * math.pi / 180),
                ),
                IconButton.filledTonal(
                  icon: const Icon(Icons.rotate_90_degrees_ccw_rounded),
                  tooltip: '-90°',
                  onPressed: () => _updateSelectedSlotRotation(-math.pi / 2),
                ),
                IconButton.filledTonal(
                  icon: const Icon(Icons.rotate_90_degrees_cw_rounded),
                  tooltip: '+90°',
                  onPressed: () => _updateSelectedSlotRotation(math.pi / 2),
                ),
                IconButton.filledTonal(
                  icon: const Icon(Icons.rotate_right_rounded),
                  tooltip: '+15°',
                  onPressed: () => _updateSelectedSlotRotation(15 * math.pi / 180),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Center(
              child: Text(
                '${(slot.rotation * 180 / math.pi).round() % 360}°',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),

            const Divider(height: 36, color: Color(0xFF334155)),

            // Delete slot button
            ElevatedButton.icon(
              onPressed: _deleteSelectedSlot,
              icon: const Icon(Icons.delete_sweep_rounded),
              label: const Text('Eliminar Lote'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.occupied,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
