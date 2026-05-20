import 'rental_transaction.dart';

abstract class IRentalRepository {
  Stream<List<RentalTransaction>> watchActiveRentals();
  Future<List<RentalTransaction>> getActiveRentals();
  Future<List<RentalTransaction>> getAllRentals();
  Future<void> saveRental(RentalTransaction rental);
  Future<RentalTransaction?> getRentalById(String rentalId);
}
