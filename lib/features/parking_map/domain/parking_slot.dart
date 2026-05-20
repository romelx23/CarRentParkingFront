enum SlotStatus {
  available,
  occupied,
  reserved;

  String get value {
    switch (this) {
      case SlotStatus.available:
        return 'available';
      case SlotStatus.occupied:
        return 'occupied';
      case SlotStatus.reserved:
        return 'reserved';
    }
  }

  static SlotStatus fromString(String val) {
    return SlotStatus.values.firstWhere(
      (e) => e.name == val || e.value == val,
      orElse: () => SlotStatus.available,
    );
  }
}

enum SlotType {
  standard,
  large,
  disabled;

  String get value {
    switch (this) {
      case SlotType.standard:
        return 'standard';
      case SlotType.large:
        return 'large';
      case SlotType.disabled:
        return 'disabled';
    }
  }

  static SlotType fromString(String val) {
    return SlotType.values.firstWhere(
      (e) => e.name == val || e.value == val,
      orElse: () => SlotType.standard,
    );
  }
}

class ParkingSlot {
  final String id;
  final String label;
  final double x;
  final double y;
  final double width;
  final double height;
  final double rotation; // in radians
  final SlotStatus status;
  final SlotType type;
  final double? hourlyRate;
  final String? activeRentalId;

  const ParkingSlot({
    required this.id,
    required this.label,
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    required this.rotation,
    required this.status,
    required this.type,
    this.hourlyRate,
    this.activeRentalId,
  });

  ParkingSlot copyWith({
    String? id,
    String? label,
    double? x,
    double? y,
    double? width,
    double? height,
    double? rotation,
    SlotStatus? status,
    SlotType? type,
    double? hourlyRate,
    String? activeRentalId,
  }) {
    return ParkingSlot(
      id: id ?? this.id,
      label: label ?? this.label,
      x: x ?? this.x,
      y: y ?? this.y,
      width: width ?? this.width,
      height: height ?? this.height,
      rotation: rotation ?? this.rotation,
      status: status ?? this.status,
      type: type ?? this.type,
      hourlyRate: hourlyRate ?? this.hourlyRate,
      activeRentalId: activeRentalId ?? this.activeRentalId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'label': label,
      'x': x,
      'y': y,
      'width': width,
      'height': height,
      'rotation': rotation,
      'status': status.value,
      'type': type.value,
      'hourlyRate': hourlyRate,
      'activeRentalId': activeRentalId,
    };
  }

  factory ParkingSlot.fromMap(Map<String, dynamic> map) {
    return ParkingSlot(
      id: map['id'] as String,
      label: map['label'] as String,
      x: (map['x'] as num).toDouble(),
      y: (map['y'] as num).toDouble(),
      width: (map['width'] as num).toDouble(),
      height: (map['height'] as num).toDouble(),
      rotation: (map['rotation'] as num).toDouble(),
      status: SlotStatus.fromString(map['status'] as String),
      type: SlotType.fromString(map['type'] as String),
      hourlyRate: map['hourlyRate'] != null ? (map['hourlyRate'] as num).toDouble() : null,
      activeRentalId: map['activeRentalId'] as String?,
    );
  }
}
