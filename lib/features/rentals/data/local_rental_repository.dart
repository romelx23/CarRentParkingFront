import 'package:drift/drift.dart';
import '../../../core/database/local_db.dart';
import '../domain/rental_repository.dart';
import '../domain/rental_transaction.dart';

class LocalRentalRepository implements IRentalRepository {
  final ParkingDatabase _db;

  LocalRentalRepository(this._db);

  RentalTransaction _mapToDomain(RentalsTableData data) {
    return RentalTransaction(
      id: data.id,
      slotId: data.slotId,
      slotLabel: data.slotLabel,
      licensePlate: data.licensePlate,
      vehicleDetails: data.vehicleDetails,
      customerPhone: data.customerPhone,
      checkInTime: data.checkInTime,
      checkOutTime: data.checkOutTime,
      hourlyRate: data.hourlyRate,
      totalAmount: data.totalAmount,
      isPaid: data.isPaid,
    );
  }

  RentalsTableCompanion _mapToCompanion(RentalTransaction rental) {
    return RentalsTableCompanion(
      id: Value(rental.id),
      slotId: Value(rental.slotId),
      slotLabel: Value(rental.slotLabel),
      licensePlate: Value(rental.licensePlate),
      vehicleDetails: Value(rental.vehicleDetails),
      customerPhone: Value(rental.customerPhone),
      checkInTime: Value(rental.checkInTime),
      checkOutTime: Value(rental.checkOutTime),
      hourlyRate: Value(rental.hourlyRate),
      totalAmount: Value(rental.totalAmount),
      isPaid: Value(rental.isPaid),
    );
  }

  @override
  Stream<List<RentalTransaction>> watchActiveRentals() {
    return (_db.select(_db.rentalsTable)
          ..where((t) => t.isPaid.equals(false))
          ..orderBy([
            (t) => OrderingTerm(expression: t.checkInTime, mode: OrderingMode.desc),
          ]))
        .watch()
        .map((rows) => rows.map(_mapToDomain).toList());
  }

  @override
  Future<List<RentalTransaction>> getActiveRentals() async {
    final rows = await (_db.select(_db.rentalsTable)
          ..where((t) => t.isPaid.equals(false))
          ..orderBy([
            (t) => OrderingTerm(expression: t.checkInTime, mode: OrderingMode.desc),
          ]))
        .get();
    return rows.map(_mapToDomain).toList();
  }

  @override
  Future<List<RentalTransaction>> getAllRentals() async {
    final rows = await (_db.select(_db.rentalsTable)
          ..orderBy([
            (t) => OrderingTerm(expression: t.checkInTime, mode: OrderingMode.desc),
          ]))
        .get();
    return rows.map(_mapToDomain).toList();
  }

  @override
  Future<void> saveRental(RentalTransaction rental) async {
    await _db.into(_db.rentalsTable).insertOnConflictUpdate(_mapToCompanion(rental));
  }

  @override
  Future<RentalTransaction?> getRentalById(String rentalId) async {
    final row = await (_db.select(_db.rentalsTable)..where((t) => t.id.equals(rentalId))).getSingleOrNull();
    return row != null ? _mapToDomain(row) : null;
  }
}
