import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../core/providers/database_provider.dart';
import '../domain/parking_slot.dart';
import '../../rentals/domain/rental_transaction.dart';

// Stream of all parking slots
final parkingSlotsProvider = StreamProvider<List<ParkingSlot>>((ref) {
  final repository = ref.watch(parkingRepositoryProvider);
  return repository.watchParkingSlots();
});

// Stream of all active rentals
final activeRentalsProvider = StreamProvider<List<RentalTransaction>>((ref) {
  final repository = ref.watch(rentalRepositoryProvider);
  return repository.watchActiveRentals();
});

// Stream of all rental history
final rentalHistoryProvider = FutureProvider<List<RentalTransaction>>((ref) {
  final repository = ref.watch(rentalRepositoryProvider);
  return repository.getAllRentals();
});

// Controller to manage state mutations
final parkingMapControllerProvider = StateNotifierProvider<ParkingMapController, AsyncValue<void>>((ref) {
  return ParkingMapController(ref);
});

class ParkingMapController extends StateNotifier<AsyncValue<void>> {
  final Ref _ref;

  ParkingMapController(this._ref) : super(const AsyncValue.data(null));

  Uuid get _uuid => const Uuid();

  // Add a new parking slot
  Future<void> addSlot({
    required String label,
    required double x,
    required double y,
    required double width,
    required double height,
    required double rotation,
    required SlotType type,
    double? hourlyRate,
  }) async {
    state = const AsyncValue.loading();
    try {
      final repo = _ref.read(parkingRepositoryProvider);
      final slot = ParkingSlot(
        id: _uuid.v4(),
        label: label,
        x: x,
        y: y,
        width: width,
        height: height,
        rotation: rotation,
        status: SlotStatus.available,
        type: type,
        hourlyRate: hourlyRate,
      );
      await repo.saveParkingSlot(slot);
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  // Update a single slot's details (or coordinate movement)
  Future<void> updateSlot(ParkingSlot slot) async {
    try {
      final repo = _ref.read(parkingRepositoryProvider);
      await repo.saveParkingSlot(slot);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  // Bulk update slot coordinates (ideal for editor save button)
  Future<void> saveEditedSlots(List<ParkingSlot> slots) async {
    state = const AsyncValue.loading();
    try {
      final repo = _ref.read(parkingRepositoryProvider);
      await repo.saveParkingSlots(slots);
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  // Delete a slot
  Future<void> deleteSlot(String slotId) async {
    state = const AsyncValue.loading();
    try {
      final repo = _ref.read(parkingRepositoryProvider);
      await repo.deleteParkingSlot(slotId);
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  // Check-in / Rent a spot
  Future<void> checkIn({
    required String slotId,
    required String slotLabel,
    required String licensePlate,
    String? vehicleDetails,
    String? customerPhone,
    required double hourlyRate,
  }) async {
    state = const AsyncValue.loading();
    try {
      final parkingRepo = _ref.read(parkingRepositoryProvider);
      final rentalRepo = _ref.read(rentalRepositoryProvider);
      
      final rentalId = _uuid.v4();
      
      // 1. Create and save rental transaction
      final transaction = RentalTransaction(
        id: rentalId,
        slotId: slotId,
        slotLabel: slotLabel,
        licensePlate: licensePlate,
        vehicleDetails: vehicleDetails,
        customerPhone: customerPhone,
        checkInTime: DateTime.now(),
        hourlyRate: hourlyRate,
        isPaid: false,
      );
      await rentalRepo.saveRental(transaction);

      // 2. Load existing slot to update it
      final slots = await parkingRepo.getParkingSlots();
      final slot = slots.firstWhere((s) => s.id == slotId);
      
      final updatedSlot = slot.copyWith(
        status: SlotStatus.occupied,
        activeRentalId: rentalId,
      );
      await parkingRepo.saveParkingSlot(updatedSlot);
      
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  // Check-out / Free a spot and process payment
  Future<RentalTransaction?> checkOut(String slotId) async {
    state = const AsyncValue.loading();
    try {
      final parkingRepo = _ref.read(parkingRepositoryProvider);
      final rentalRepo = _ref.read(rentalRepositoryProvider);
      
      // 1. Load the slot
      final slots = await parkingRepo.getParkingSlots();
      final slot = slots.firstWhere((s) => s.id == slotId);
      
      if (slot.activeRentalId == null) {
        throw Exception("Este lote no está ocupado.");
      }

      // 2. Load the rental transaction
      final rental = await rentalRepo.getRentalById(slot.activeRentalId!);
      if (rental == null) {
        throw Exception("Renta no encontrada.");
      }

      // 3. Finalize rental transaction
      final now = DateTime.now();
      final difference = now.difference(rental.checkInTime);
      final hours = difference.inMinutes / 60.0;
      final chargeableHours = hours < 1.0 ? 1.0 : hours;
      final finalAmount = double.parse((chargeableHours * rental.hourlyRate).toStringAsFixed(2));

      final completedRental = rental.copyWith(
        checkOutTime: now,
        totalAmount: finalAmount,
        isPaid: true,
      );
      await rentalRepo.saveRental(completedRental);

      // 4. Reset slot status to available
      final updatedSlot = slot.copyWith(
        status: SlotStatus.available,
        activeRentalId: null,
      );
      await parkingRepo.saveParkingSlot(updatedSlot);
      
      state = const AsyncValue.data(null);
      return completedRental;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return null;
    }
  }

  // Seeder to generate a predefined aesthetic 2D parking lot setup
  Future<void> seedDemoData() async {
    state = const AsyncValue.loading();
    try {
      final parkingRepo = _ref.read(parkingRepositoryProvider);
      
      // Clear existing slots first
      final existing = await parkingRepo.getParkingSlots();
      for (final slot in existing) {
        await parkingRepo.deleteParkingSlot(slot.id);
      }

      final List<ParkingSlot> demoSlots = [
        // Fila Superior (Row A) - y: 160
        ParkingSlot(id: 'a01', label: 'A-01', x: 180, y: 160, width: 75, height: 130, rotation: 0, status: SlotStatus.available, type: SlotType.standard, hourlyRate: 12.0),
        ParkingSlot(id: 'a02', label: 'A-02', x: 280, y: 160, width: 75, height: 130, rotation: 0, status: SlotStatus.available, type: SlotType.standard, hourlyRate: 12.0),
        ParkingSlot(id: 'a03', label: 'A-03', x: 380, y: 160, width: 75, height: 130, rotation: 0, status: SlotStatus.available, type: SlotType.disabled, hourlyRate: 10.0),
        ParkingSlot(id: 'a04', label: 'A-04', x: 480, y: 160, width: 75, height: 130, rotation: 0, status: SlotStatus.available, type: SlotType.standard, hourlyRate: 12.0),
        ParkingSlot(id: 'a05', label: 'A-05', x: 580, y: 160, width: 75, height: 130, rotation: 0, status: SlotStatus.available, type: SlotType.standard, hourlyRate: 12.0),
        
        // Fila Superior Derecha (Row B) - y: 160
        ParkingSlot(id: 'b01', label: 'B-01', x: 740, y: 160, width: 75, height: 130, rotation: 0, status: SlotStatus.available, type: SlotType.large, hourlyRate: 15.0),
        ParkingSlot(id: 'b02', label: 'B-02', x: 840, y: 160, width: 75, height: 130, rotation: 0, status: SlotStatus.available, type: SlotType.large, hourlyRate: 15.0),
        ParkingSlot(id: 'b03', label: 'B-03', x: 940, y: 160, width: 75, height: 130, rotation: 0, status: SlotStatus.available, type: SlotType.standard, hourlyRate: 12.0),

        // Fila Inferior Izquierda (Row C) - y: 610
        ParkingSlot(id: 'c01', label: 'C-01', x: 180, y: 610, width: 75, height: 130, rotation: 0, status: SlotStatus.available, type: SlotType.standard, hourlyRate: 12.0),
        ParkingSlot(id: 'c02', label: 'C-02', x: 280, y: 610, width: 75, height: 130, rotation: 0, status: SlotStatus.available, type: SlotType.standard, hourlyRate: 12.0),
        ParkingSlot(id: 'c03', label: 'C-03', x: 380, y: 610, width: 75, height: 130, rotation: 0, status: SlotStatus.available, type: SlotType.disabled, hourlyRate: 10.0),
        ParkingSlot(id: 'c04', label: 'C-04', x: 480, y: 610, width: 75, height: 130, rotation: 0, status: SlotStatus.available, type: SlotType.standard, hourlyRate: 12.0),
        
        // Fila Inferior Derecha (Row D) - y: 610
        ParkingSlot(id: 'd01', label: 'D-01', x: 740, y: 610, width: 75, height: 130, rotation: 0, status: SlotStatus.available, type: SlotType.large, hourlyRate: 15.0),
        ParkingSlot(id: 'd02', label: 'D-02', x: 840, y: 610, width: 75, height: 130, rotation: 0, status: SlotStatus.available, type: SlotType.large, hourlyRate: 15.0),
        ParkingSlot(id: 'd03', label: 'D-03', x: 940, y: 610, width: 75, height: 130, rotation: 0, status: SlotStatus.available, type: SlotType.standard, hourlyRate: 12.0),
      ];

      await parkingRepo.saveParkingSlots(demoSlots);
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
