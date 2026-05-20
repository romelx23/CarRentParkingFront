import 'package:drift/drift.dart';
import '../../../core/database/local_db.dart';
import '../domain/parking_repository.dart';
import '../domain/parking_slot.dart';

class LocalParkingRepository implements IParkingRepository {
  final ParkingDatabase _db;

  LocalParkingRepository(this._db);

  ParkingSlot _mapToDomain(ParkingSlotsTableData data) {
    return ParkingSlot(
      id: data.id,
      label: data.label,
      x: data.x,
      y: data.y,
      width: data.width,
      height: data.height,
      rotation: data.rotation,
      status: SlotStatus.fromString(data.status),
      type: SlotType.fromString(data.type),
      hourlyRate: data.hourlyRate,
      activeRentalId: data.activeRentalId,
    );
  }

  ParkingSlotsTableCompanion _mapToCompanion(ParkingSlot slot) {
    return ParkingSlotsTableCompanion(
      id: Value(slot.id),
      label: Value(slot.label),
      x: Value(slot.x),
      y: Value(slot.y),
      width: Value(slot.width),
      height: Value(slot.height),
      rotation: Value(slot.rotation),
      status: Value(slot.status.value),
      type: Value(slot.type.value),
      hourlyRate: Value(slot.hourlyRate),
      activeRentalId: Value(slot.activeRentalId),
    );
  }

  @override
  Stream<List<ParkingSlot>> watchParkingSlots() {
    return (_db.select(_db.parkingSlotsTable)
          ..orderBy([
            (t) => OrderingTerm(expression: t.label),
          ]))
        .watch()
        .map((rows) => rows.map(_mapToDomain).toList());
  }

  @override
  Future<List<ParkingSlot>> getParkingSlots() async {
    final rows = await (_db.select(_db.parkingSlotsTable)
          ..orderBy([
            (t) => OrderingTerm(expression: t.label),
          ]))
        .get();
    return rows.map(_mapToDomain).toList();
  }

  @override
  Future<void> saveParkingSlot(ParkingSlot slot) async {
    await _db.into(_db.parkingSlotsTable).insertOnConflictUpdate(_mapToCompanion(slot));
  }

  @override
  Future<void> saveParkingSlots(List<ParkingSlot> slots) async {
    await _db.batch((batch) {
      for (final slot in slots) {
        batch.insert(
          _db.parkingSlotsTable,
          _mapToCompanion(slot),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  @override
  Future<void> deleteParkingSlot(String slotId) async {
    await (_db.delete(_db.parkingSlotsTable)..where((t) => t.id.equals(slotId))).go();
  }
}
