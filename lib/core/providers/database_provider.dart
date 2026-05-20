import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/local_db.dart';
import '../../features/parking_map/domain/parking_repository.dart';
import '../../features/parking_map/data/local_parking_repository.dart';
import '../../features/rentals/domain/rental_repository.dart';
import '../../features/rentals/data/local_rental_repository.dart';

final databaseProvider = Provider<ParkingDatabase>((ref) {
  final db = ParkingDatabase();
  ref.onDispose(() => db.close());
  return db;
});

final parkingRepositoryProvider = Provider<IParkingRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return LocalParkingRepository(db);
});

final rentalRepositoryProvider = Provider<IRentalRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return LocalRentalRepository(db);
});
