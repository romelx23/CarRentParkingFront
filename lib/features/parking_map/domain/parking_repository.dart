import 'parking_slot.dart';

abstract class IParkingRepository {
  Stream<List<ParkingSlot>> watchParkingSlots();
  Future<List<ParkingSlot>> getParkingSlots();
  Future<void> saveParkingSlot(ParkingSlot slot);
  Future<void> saveParkingSlots(List<ParkingSlot> slots);
  Future<void> deleteParkingSlot(String slotId);
}
