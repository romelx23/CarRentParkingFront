class RentalTransaction {
  final String id;
  final String slotId;
  final String slotLabel;
  final String licensePlate;
  final String? vehicleDetails;
  final String? customerPhone;
  final DateTime checkInTime;
  final DateTime? checkOutTime;
  final double hourlyRate;
  final double? totalAmount;
  final bool isPaid;

  const RentalTransaction({
    required this.id,
    required this.slotId,
    required this.slotLabel,
    required this.licensePlate,
    this.vehicleDetails,
    this.customerPhone,
    required this.checkInTime,
    this.checkOutTime,
    required this.hourlyRate,
    this.totalAmount,
    required this.isPaid,
  });

  RentalTransaction copyWith({
    String? id,
    String? slotId,
    String? slotLabel,
    String? licensePlate,
    String? vehicleDetails,
    String? customerPhone,
    DateTime? checkInTime,
    DateTime? checkOutTime,
    double? hourlyRate,
    double? totalAmount,
    bool? isPaid,
  }) {
    return RentalTransaction(
      id: id ?? this.id,
      slotId: slotId ?? this.slotId,
      slotLabel: slotLabel ?? this.slotLabel,
      licensePlate: licensePlate ?? this.licensePlate,
      vehicleDetails: vehicleDetails ?? this.vehicleDetails,
      customerPhone: customerPhone ?? this.customerPhone,
      checkInTime: checkInTime ?? this.checkInTime,
      checkOutTime: checkOutTime ?? this.checkOutTime,
      hourlyRate: hourlyRate ?? this.hourlyRate,
      totalAmount: totalAmount ?? this.totalAmount,
      isPaid: isPaid ?? this.isPaid,
    );
  }

  // Helper method to calculate current duration and rate
  double calculateCurrentAmount() {
    final end = checkOutTime ?? DateTime.now();
    final difference = end.difference(checkInTime);
    
    // Minimum 1 hour charge
    final hours = difference.inMinutes / 60.0;
    final chargeableHours = hours < 1.0 ? 1.0 : hours;
    
    return double.parse((chargeableHours * hourlyRate).toStringAsFixed(2));
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'slotId': slotId,
      'slotLabel': slotLabel,
      'licensePlate': licensePlate,
      'vehicleDetails': vehicleDetails,
      'customerPhone': customerPhone,
      'checkInTime': checkInTime.toIso8601String(),
      'checkOutTime': checkOutTime?.toIso8601String(),
      'hourlyRate': hourlyRate,
      'totalAmount': totalAmount,
      'isPaid': isPaid ? 1 : 0, // Drift standard or JSON
    };
  }

  factory RentalTransaction.fromMap(Map<String, dynamic> map) {
    return RentalTransaction(
      id: map['id'] as String,
      slotId: map['slotId'] as String,
      slotLabel: map['slotLabel'] as String,
      licensePlate: map['licensePlate'] as String,
      vehicleDetails: map['vehicleDetails'] as String?,
      customerPhone: map['customerPhone'] as String?,
      checkInTime: DateTime.parse(map['checkInTime'] as String),
      checkOutTime: map['checkOutTime'] != null ? DateTime.parse(map['checkOutTime'] as String) : null,
      hourlyRate: (map['hourlyRate'] as num).toDouble(),
      totalAmount: map['totalAmount'] != null ? (map['totalAmount'] as num).toDouble() : null,
      isPaid: (map['isPaid'] as num) == 1 || map['isPaid'] == true,
    );
  }
}
