import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'local_db.g.dart';

class ParkingSlotsTable extends Table {
  TextColumn get id => text()();
  TextColumn get label => text()();
  RealColumn get x => real()();
  RealColumn get y => real()();
  RealColumn get width => real()();
  RealColumn get height => real()();
  RealColumn get rotation => real()();
  TextColumn get status => text()();
  TextColumn get type => text()();
  RealColumn get hourlyRate => real().nullable()();
  TextColumn get activeRentalId => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class RentalsTable extends Table {
  TextColumn get id => text()();
  TextColumn get slotId => text()();
  TextColumn get slotLabel => text()();
  TextColumn get licensePlate => text()();
  TextColumn get vehicleDetails => text().nullable()();
  TextColumn get customerPhone => text().nullable()();
  DateTimeColumn get checkInTime => dateTime()();
  DateTimeColumn get checkOutTime => dateTime().nullable()();
  RealColumn get hourlyRate => real()();
  RealColumn get totalAmount => real().nullable()();
  BoolColumn get isPaid => boolean()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [ParkingSlotsTable, RentalsTable])
class ParkingDatabase extends _$ParkingDatabase {
  ParkingDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'parking.db'));
    return NativeDatabase.createInBackground(file);
  });
}
