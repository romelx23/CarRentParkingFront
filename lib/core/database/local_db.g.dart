// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_db.dart';

// ignore_for_file: type=lint
class $ParkingSlotsTableTable extends ParkingSlotsTable
    with TableInfo<$ParkingSlotsTableTable, ParkingSlotsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ParkingSlotsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _xMeta = const VerificationMeta('x');
  @override
  late final GeneratedColumn<double> x = GeneratedColumn<double>(
    'x',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _yMeta = const VerificationMeta('y');
  @override
  late final GeneratedColumn<double> y = GeneratedColumn<double>(
    'y',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _widthMeta = const VerificationMeta('width');
  @override
  late final GeneratedColumn<double> width = GeneratedColumn<double>(
    'width',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<double> height = GeneratedColumn<double>(
    'height',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rotationMeta = const VerificationMeta(
    'rotation',
  );
  @override
  late final GeneratedColumn<double> rotation = GeneratedColumn<double>(
    'rotation',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hourlyRateMeta = const VerificationMeta(
    'hourlyRate',
  );
  @override
  late final GeneratedColumn<double> hourlyRate = GeneratedColumn<double>(
    'hourly_rate',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _activeRentalIdMeta = const VerificationMeta(
    'activeRentalId',
  );
  @override
  late final GeneratedColumn<String> activeRentalId = GeneratedColumn<String>(
    'active_rental_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    label,
    x,
    y,
    width,
    height,
    rotation,
    status,
    type,
    hourlyRate,
    activeRentalId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'parking_slots_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ParkingSlotsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('x')) {
      context.handle(_xMeta, x.isAcceptableOrUnknown(data['x']!, _xMeta));
    } else if (isInserting) {
      context.missing(_xMeta);
    }
    if (data.containsKey('y')) {
      context.handle(_yMeta, y.isAcceptableOrUnknown(data['y']!, _yMeta));
    } else if (isInserting) {
      context.missing(_yMeta);
    }
    if (data.containsKey('width')) {
      context.handle(
        _widthMeta,
        width.isAcceptableOrUnknown(data['width']!, _widthMeta),
      );
    } else if (isInserting) {
      context.missing(_widthMeta);
    }
    if (data.containsKey('height')) {
      context.handle(
        _heightMeta,
        height.isAcceptableOrUnknown(data['height']!, _heightMeta),
      );
    } else if (isInserting) {
      context.missing(_heightMeta);
    }
    if (data.containsKey('rotation')) {
      context.handle(
        _rotationMeta,
        rotation.isAcceptableOrUnknown(data['rotation']!, _rotationMeta),
      );
    } else if (isInserting) {
      context.missing(_rotationMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('hourly_rate')) {
      context.handle(
        _hourlyRateMeta,
        hourlyRate.isAcceptableOrUnknown(data['hourly_rate']!, _hourlyRateMeta),
      );
    }
    if (data.containsKey('active_rental_id')) {
      context.handle(
        _activeRentalIdMeta,
        activeRentalId.isAcceptableOrUnknown(
          data['active_rental_id']!,
          _activeRentalIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ParkingSlotsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ParkingSlotsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      x: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}x'],
      )!,
      y: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}y'],
      )!,
      width: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}width'],
      )!,
      height: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}height'],
      )!,
      rotation: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rotation'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      hourlyRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}hourly_rate'],
      ),
      activeRentalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}active_rental_id'],
      ),
    );
  }

  @override
  $ParkingSlotsTableTable createAlias(String alias) {
    return $ParkingSlotsTableTable(attachedDatabase, alias);
  }
}

class ParkingSlotsTableData extends DataClass
    implements Insertable<ParkingSlotsTableData> {
  final String id;
  final String label;
  final double x;
  final double y;
  final double width;
  final double height;
  final double rotation;
  final String status;
  final String type;
  final double? hourlyRate;
  final String? activeRentalId;
  const ParkingSlotsTableData({
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
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['label'] = Variable<String>(label);
    map['x'] = Variable<double>(x);
    map['y'] = Variable<double>(y);
    map['width'] = Variable<double>(width);
    map['height'] = Variable<double>(height);
    map['rotation'] = Variable<double>(rotation);
    map['status'] = Variable<String>(status);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || hourlyRate != null) {
      map['hourly_rate'] = Variable<double>(hourlyRate);
    }
    if (!nullToAbsent || activeRentalId != null) {
      map['active_rental_id'] = Variable<String>(activeRentalId);
    }
    return map;
  }

  ParkingSlotsTableCompanion toCompanion(bool nullToAbsent) {
    return ParkingSlotsTableCompanion(
      id: Value(id),
      label: Value(label),
      x: Value(x),
      y: Value(y),
      width: Value(width),
      height: Value(height),
      rotation: Value(rotation),
      status: Value(status),
      type: Value(type),
      hourlyRate: hourlyRate == null && nullToAbsent
          ? const Value.absent()
          : Value(hourlyRate),
      activeRentalId: activeRentalId == null && nullToAbsent
          ? const Value.absent()
          : Value(activeRentalId),
    );
  }

  factory ParkingSlotsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ParkingSlotsTableData(
      id: serializer.fromJson<String>(json['id']),
      label: serializer.fromJson<String>(json['label']),
      x: serializer.fromJson<double>(json['x']),
      y: serializer.fromJson<double>(json['y']),
      width: serializer.fromJson<double>(json['width']),
      height: serializer.fromJson<double>(json['height']),
      rotation: serializer.fromJson<double>(json['rotation']),
      status: serializer.fromJson<String>(json['status']),
      type: serializer.fromJson<String>(json['type']),
      hourlyRate: serializer.fromJson<double?>(json['hourlyRate']),
      activeRentalId: serializer.fromJson<String?>(json['activeRentalId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'label': serializer.toJson<String>(label),
      'x': serializer.toJson<double>(x),
      'y': serializer.toJson<double>(y),
      'width': serializer.toJson<double>(width),
      'height': serializer.toJson<double>(height),
      'rotation': serializer.toJson<double>(rotation),
      'status': serializer.toJson<String>(status),
      'type': serializer.toJson<String>(type),
      'hourlyRate': serializer.toJson<double?>(hourlyRate),
      'activeRentalId': serializer.toJson<String?>(activeRentalId),
    };
  }

  ParkingSlotsTableData copyWith({
    String? id,
    String? label,
    double? x,
    double? y,
    double? width,
    double? height,
    double? rotation,
    String? status,
    String? type,
    Value<double?> hourlyRate = const Value.absent(),
    Value<String?> activeRentalId = const Value.absent(),
  }) => ParkingSlotsTableData(
    id: id ?? this.id,
    label: label ?? this.label,
    x: x ?? this.x,
    y: y ?? this.y,
    width: width ?? this.width,
    height: height ?? this.height,
    rotation: rotation ?? this.rotation,
    status: status ?? this.status,
    type: type ?? this.type,
    hourlyRate: hourlyRate.present ? hourlyRate.value : this.hourlyRate,
    activeRentalId: activeRentalId.present
        ? activeRentalId.value
        : this.activeRentalId,
  );
  ParkingSlotsTableData copyWithCompanion(ParkingSlotsTableCompanion data) {
    return ParkingSlotsTableData(
      id: data.id.present ? data.id.value : this.id,
      label: data.label.present ? data.label.value : this.label,
      x: data.x.present ? data.x.value : this.x,
      y: data.y.present ? data.y.value : this.y,
      width: data.width.present ? data.width.value : this.width,
      height: data.height.present ? data.height.value : this.height,
      rotation: data.rotation.present ? data.rotation.value : this.rotation,
      status: data.status.present ? data.status.value : this.status,
      type: data.type.present ? data.type.value : this.type,
      hourlyRate: data.hourlyRate.present
          ? data.hourlyRate.value
          : this.hourlyRate,
      activeRentalId: data.activeRentalId.present
          ? data.activeRentalId.value
          : this.activeRentalId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ParkingSlotsTableData(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('x: $x, ')
          ..write('y: $y, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('rotation: $rotation, ')
          ..write('status: $status, ')
          ..write('type: $type, ')
          ..write('hourlyRate: $hourlyRate, ')
          ..write('activeRentalId: $activeRentalId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    label,
    x,
    y,
    width,
    height,
    rotation,
    status,
    type,
    hourlyRate,
    activeRentalId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ParkingSlotsTableData &&
          other.id == this.id &&
          other.label == this.label &&
          other.x == this.x &&
          other.y == this.y &&
          other.width == this.width &&
          other.height == this.height &&
          other.rotation == this.rotation &&
          other.status == this.status &&
          other.type == this.type &&
          other.hourlyRate == this.hourlyRate &&
          other.activeRentalId == this.activeRentalId);
}

class ParkingSlotsTableCompanion
    extends UpdateCompanion<ParkingSlotsTableData> {
  final Value<String> id;
  final Value<String> label;
  final Value<double> x;
  final Value<double> y;
  final Value<double> width;
  final Value<double> height;
  final Value<double> rotation;
  final Value<String> status;
  final Value<String> type;
  final Value<double?> hourlyRate;
  final Value<String?> activeRentalId;
  final Value<int> rowid;
  const ParkingSlotsTableCompanion({
    this.id = const Value.absent(),
    this.label = const Value.absent(),
    this.x = const Value.absent(),
    this.y = const Value.absent(),
    this.width = const Value.absent(),
    this.height = const Value.absent(),
    this.rotation = const Value.absent(),
    this.status = const Value.absent(),
    this.type = const Value.absent(),
    this.hourlyRate = const Value.absent(),
    this.activeRentalId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ParkingSlotsTableCompanion.insert({
    required String id,
    required String label,
    required double x,
    required double y,
    required double width,
    required double height,
    required double rotation,
    required String status,
    required String type,
    this.hourlyRate = const Value.absent(),
    this.activeRentalId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       label = Value(label),
       x = Value(x),
       y = Value(y),
       width = Value(width),
       height = Value(height),
       rotation = Value(rotation),
       status = Value(status),
       type = Value(type);
  static Insertable<ParkingSlotsTableData> custom({
    Expression<String>? id,
    Expression<String>? label,
    Expression<double>? x,
    Expression<double>? y,
    Expression<double>? width,
    Expression<double>? height,
    Expression<double>? rotation,
    Expression<String>? status,
    Expression<String>? type,
    Expression<double>? hourlyRate,
    Expression<String>? activeRentalId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (label != null) 'label': label,
      if (x != null) 'x': x,
      if (y != null) 'y': y,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
      if (rotation != null) 'rotation': rotation,
      if (status != null) 'status': status,
      if (type != null) 'type': type,
      if (hourlyRate != null) 'hourly_rate': hourlyRate,
      if (activeRentalId != null) 'active_rental_id': activeRentalId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ParkingSlotsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? label,
    Value<double>? x,
    Value<double>? y,
    Value<double>? width,
    Value<double>? height,
    Value<double>? rotation,
    Value<String>? status,
    Value<String>? type,
    Value<double?>? hourlyRate,
    Value<String?>? activeRentalId,
    Value<int>? rowid,
  }) {
    return ParkingSlotsTableCompanion(
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
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (x.present) {
      map['x'] = Variable<double>(x.value);
    }
    if (y.present) {
      map['y'] = Variable<double>(y.value);
    }
    if (width.present) {
      map['width'] = Variable<double>(width.value);
    }
    if (height.present) {
      map['height'] = Variable<double>(height.value);
    }
    if (rotation.present) {
      map['rotation'] = Variable<double>(rotation.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (hourlyRate.present) {
      map['hourly_rate'] = Variable<double>(hourlyRate.value);
    }
    if (activeRentalId.present) {
      map['active_rental_id'] = Variable<String>(activeRentalId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ParkingSlotsTableCompanion(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('x: $x, ')
          ..write('y: $y, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('rotation: $rotation, ')
          ..write('status: $status, ')
          ..write('type: $type, ')
          ..write('hourlyRate: $hourlyRate, ')
          ..write('activeRentalId: $activeRentalId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RentalsTableTable extends RentalsTable
    with TableInfo<$RentalsTableTable, RentalsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RentalsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _slotIdMeta = const VerificationMeta('slotId');
  @override
  late final GeneratedColumn<String> slotId = GeneratedColumn<String>(
    'slot_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _slotLabelMeta = const VerificationMeta(
    'slotLabel',
  );
  @override
  late final GeneratedColumn<String> slotLabel = GeneratedColumn<String>(
    'slot_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _licensePlateMeta = const VerificationMeta(
    'licensePlate',
  );
  @override
  late final GeneratedColumn<String> licensePlate = GeneratedColumn<String>(
    'license_plate',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vehicleDetailsMeta = const VerificationMeta(
    'vehicleDetails',
  );
  @override
  late final GeneratedColumn<String> vehicleDetails = GeneratedColumn<String>(
    'vehicle_details',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customerPhoneMeta = const VerificationMeta(
    'customerPhone',
  );
  @override
  late final GeneratedColumn<String> customerPhone = GeneratedColumn<String>(
    'customer_phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _checkInTimeMeta = const VerificationMeta(
    'checkInTime',
  );
  @override
  late final GeneratedColumn<DateTime> checkInTime = GeneratedColumn<DateTime>(
    'check_in_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _checkOutTimeMeta = const VerificationMeta(
    'checkOutTime',
  );
  @override
  late final GeneratedColumn<DateTime> checkOutTime = GeneratedColumn<DateTime>(
    'check_out_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hourlyRateMeta = const VerificationMeta(
    'hourlyRate',
  );
  @override
  late final GeneratedColumn<double> hourlyRate = GeneratedColumn<double>(
    'hourly_rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
    'total_amount',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isPaidMeta = const VerificationMeta('isPaid');
  @override
  late final GeneratedColumn<bool> isPaid = GeneratedColumn<bool>(
    'is_paid',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_paid" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    slotId,
    slotLabel,
    licensePlate,
    vehicleDetails,
    customerPhone,
    checkInTime,
    checkOutTime,
    hourlyRate,
    totalAmount,
    isPaid,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rentals_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<RentalsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('slot_id')) {
      context.handle(
        _slotIdMeta,
        slotId.isAcceptableOrUnknown(data['slot_id']!, _slotIdMeta),
      );
    } else if (isInserting) {
      context.missing(_slotIdMeta);
    }
    if (data.containsKey('slot_label')) {
      context.handle(
        _slotLabelMeta,
        slotLabel.isAcceptableOrUnknown(data['slot_label']!, _slotLabelMeta),
      );
    } else if (isInserting) {
      context.missing(_slotLabelMeta);
    }
    if (data.containsKey('license_plate')) {
      context.handle(
        _licensePlateMeta,
        licensePlate.isAcceptableOrUnknown(
          data['license_plate']!,
          _licensePlateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_licensePlateMeta);
    }
    if (data.containsKey('vehicle_details')) {
      context.handle(
        _vehicleDetailsMeta,
        vehicleDetails.isAcceptableOrUnknown(
          data['vehicle_details']!,
          _vehicleDetailsMeta,
        ),
      );
    }
    if (data.containsKey('customer_phone')) {
      context.handle(
        _customerPhoneMeta,
        customerPhone.isAcceptableOrUnknown(
          data['customer_phone']!,
          _customerPhoneMeta,
        ),
      );
    }
    if (data.containsKey('check_in_time')) {
      context.handle(
        _checkInTimeMeta,
        checkInTime.isAcceptableOrUnknown(
          data['check_in_time']!,
          _checkInTimeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_checkInTimeMeta);
    }
    if (data.containsKey('check_out_time')) {
      context.handle(
        _checkOutTimeMeta,
        checkOutTime.isAcceptableOrUnknown(
          data['check_out_time']!,
          _checkOutTimeMeta,
        ),
      );
    }
    if (data.containsKey('hourly_rate')) {
      context.handle(
        _hourlyRateMeta,
        hourlyRate.isAcceptableOrUnknown(data['hourly_rate']!, _hourlyRateMeta),
      );
    } else if (isInserting) {
      context.missing(_hourlyRateMeta);
    }
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
        ),
      );
    }
    if (data.containsKey('is_paid')) {
      context.handle(
        _isPaidMeta,
        isPaid.isAcceptableOrUnknown(data['is_paid']!, _isPaidMeta),
      );
    } else if (isInserting) {
      context.missing(_isPaidMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RentalsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RentalsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      slotId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slot_id'],
      )!,
      slotLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slot_label'],
      )!,
      licensePlate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}license_plate'],
      )!,
      vehicleDetails: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicle_details'],
      ),
      customerPhone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_phone'],
      ),
      checkInTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}check_in_time'],
      )!,
      checkOutTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}check_out_time'],
      ),
      hourlyRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}hourly_rate'],
      )!,
      totalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_amount'],
      ),
      isPaid: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_paid'],
      )!,
    );
  }

  @override
  $RentalsTableTable createAlias(String alias) {
    return $RentalsTableTable(attachedDatabase, alias);
  }
}

class RentalsTableData extends DataClass
    implements Insertable<RentalsTableData> {
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
  const RentalsTableData({
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
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['slot_id'] = Variable<String>(slotId);
    map['slot_label'] = Variable<String>(slotLabel);
    map['license_plate'] = Variable<String>(licensePlate);
    if (!nullToAbsent || vehicleDetails != null) {
      map['vehicle_details'] = Variable<String>(vehicleDetails);
    }
    if (!nullToAbsent || customerPhone != null) {
      map['customer_phone'] = Variable<String>(customerPhone);
    }
    map['check_in_time'] = Variable<DateTime>(checkInTime);
    if (!nullToAbsent || checkOutTime != null) {
      map['check_out_time'] = Variable<DateTime>(checkOutTime);
    }
    map['hourly_rate'] = Variable<double>(hourlyRate);
    if (!nullToAbsent || totalAmount != null) {
      map['total_amount'] = Variable<double>(totalAmount);
    }
    map['is_paid'] = Variable<bool>(isPaid);
    return map;
  }

  RentalsTableCompanion toCompanion(bool nullToAbsent) {
    return RentalsTableCompanion(
      id: Value(id),
      slotId: Value(slotId),
      slotLabel: Value(slotLabel),
      licensePlate: Value(licensePlate),
      vehicleDetails: vehicleDetails == null && nullToAbsent
          ? const Value.absent()
          : Value(vehicleDetails),
      customerPhone: customerPhone == null && nullToAbsent
          ? const Value.absent()
          : Value(customerPhone),
      checkInTime: Value(checkInTime),
      checkOutTime: checkOutTime == null && nullToAbsent
          ? const Value.absent()
          : Value(checkOutTime),
      hourlyRate: Value(hourlyRate),
      totalAmount: totalAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(totalAmount),
      isPaid: Value(isPaid),
    );
  }

  factory RentalsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RentalsTableData(
      id: serializer.fromJson<String>(json['id']),
      slotId: serializer.fromJson<String>(json['slotId']),
      slotLabel: serializer.fromJson<String>(json['slotLabel']),
      licensePlate: serializer.fromJson<String>(json['licensePlate']),
      vehicleDetails: serializer.fromJson<String?>(json['vehicleDetails']),
      customerPhone: serializer.fromJson<String?>(json['customerPhone']),
      checkInTime: serializer.fromJson<DateTime>(json['checkInTime']),
      checkOutTime: serializer.fromJson<DateTime?>(json['checkOutTime']),
      hourlyRate: serializer.fromJson<double>(json['hourlyRate']),
      totalAmount: serializer.fromJson<double?>(json['totalAmount']),
      isPaid: serializer.fromJson<bool>(json['isPaid']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'slotId': serializer.toJson<String>(slotId),
      'slotLabel': serializer.toJson<String>(slotLabel),
      'licensePlate': serializer.toJson<String>(licensePlate),
      'vehicleDetails': serializer.toJson<String?>(vehicleDetails),
      'customerPhone': serializer.toJson<String?>(customerPhone),
      'checkInTime': serializer.toJson<DateTime>(checkInTime),
      'checkOutTime': serializer.toJson<DateTime?>(checkOutTime),
      'hourlyRate': serializer.toJson<double>(hourlyRate),
      'totalAmount': serializer.toJson<double?>(totalAmount),
      'isPaid': serializer.toJson<bool>(isPaid),
    };
  }

  RentalsTableData copyWith({
    String? id,
    String? slotId,
    String? slotLabel,
    String? licensePlate,
    Value<String?> vehicleDetails = const Value.absent(),
    Value<String?> customerPhone = const Value.absent(),
    DateTime? checkInTime,
    Value<DateTime?> checkOutTime = const Value.absent(),
    double? hourlyRate,
    Value<double?> totalAmount = const Value.absent(),
    bool? isPaid,
  }) => RentalsTableData(
    id: id ?? this.id,
    slotId: slotId ?? this.slotId,
    slotLabel: slotLabel ?? this.slotLabel,
    licensePlate: licensePlate ?? this.licensePlate,
    vehicleDetails: vehicleDetails.present
        ? vehicleDetails.value
        : this.vehicleDetails,
    customerPhone: customerPhone.present
        ? customerPhone.value
        : this.customerPhone,
    checkInTime: checkInTime ?? this.checkInTime,
    checkOutTime: checkOutTime.present ? checkOutTime.value : this.checkOutTime,
    hourlyRate: hourlyRate ?? this.hourlyRate,
    totalAmount: totalAmount.present ? totalAmount.value : this.totalAmount,
    isPaid: isPaid ?? this.isPaid,
  );
  RentalsTableData copyWithCompanion(RentalsTableCompanion data) {
    return RentalsTableData(
      id: data.id.present ? data.id.value : this.id,
      slotId: data.slotId.present ? data.slotId.value : this.slotId,
      slotLabel: data.slotLabel.present ? data.slotLabel.value : this.slotLabel,
      licensePlate: data.licensePlate.present
          ? data.licensePlate.value
          : this.licensePlate,
      vehicleDetails: data.vehicleDetails.present
          ? data.vehicleDetails.value
          : this.vehicleDetails,
      customerPhone: data.customerPhone.present
          ? data.customerPhone.value
          : this.customerPhone,
      checkInTime: data.checkInTime.present
          ? data.checkInTime.value
          : this.checkInTime,
      checkOutTime: data.checkOutTime.present
          ? data.checkOutTime.value
          : this.checkOutTime,
      hourlyRate: data.hourlyRate.present
          ? data.hourlyRate.value
          : this.hourlyRate,
      totalAmount: data.totalAmount.present
          ? data.totalAmount.value
          : this.totalAmount,
      isPaid: data.isPaid.present ? data.isPaid.value : this.isPaid,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RentalsTableData(')
          ..write('id: $id, ')
          ..write('slotId: $slotId, ')
          ..write('slotLabel: $slotLabel, ')
          ..write('licensePlate: $licensePlate, ')
          ..write('vehicleDetails: $vehicleDetails, ')
          ..write('customerPhone: $customerPhone, ')
          ..write('checkInTime: $checkInTime, ')
          ..write('checkOutTime: $checkOutTime, ')
          ..write('hourlyRate: $hourlyRate, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('isPaid: $isPaid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    slotId,
    slotLabel,
    licensePlate,
    vehicleDetails,
    customerPhone,
    checkInTime,
    checkOutTime,
    hourlyRate,
    totalAmount,
    isPaid,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RentalsTableData &&
          other.id == this.id &&
          other.slotId == this.slotId &&
          other.slotLabel == this.slotLabel &&
          other.licensePlate == this.licensePlate &&
          other.vehicleDetails == this.vehicleDetails &&
          other.customerPhone == this.customerPhone &&
          other.checkInTime == this.checkInTime &&
          other.checkOutTime == this.checkOutTime &&
          other.hourlyRate == this.hourlyRate &&
          other.totalAmount == this.totalAmount &&
          other.isPaid == this.isPaid);
}

class RentalsTableCompanion extends UpdateCompanion<RentalsTableData> {
  final Value<String> id;
  final Value<String> slotId;
  final Value<String> slotLabel;
  final Value<String> licensePlate;
  final Value<String?> vehicleDetails;
  final Value<String?> customerPhone;
  final Value<DateTime> checkInTime;
  final Value<DateTime?> checkOutTime;
  final Value<double> hourlyRate;
  final Value<double?> totalAmount;
  final Value<bool> isPaid;
  final Value<int> rowid;
  const RentalsTableCompanion({
    this.id = const Value.absent(),
    this.slotId = const Value.absent(),
    this.slotLabel = const Value.absent(),
    this.licensePlate = const Value.absent(),
    this.vehicleDetails = const Value.absent(),
    this.customerPhone = const Value.absent(),
    this.checkInTime = const Value.absent(),
    this.checkOutTime = const Value.absent(),
    this.hourlyRate = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.isPaid = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RentalsTableCompanion.insert({
    required String id,
    required String slotId,
    required String slotLabel,
    required String licensePlate,
    this.vehicleDetails = const Value.absent(),
    this.customerPhone = const Value.absent(),
    required DateTime checkInTime,
    this.checkOutTime = const Value.absent(),
    required double hourlyRate,
    this.totalAmount = const Value.absent(),
    required bool isPaid,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       slotId = Value(slotId),
       slotLabel = Value(slotLabel),
       licensePlate = Value(licensePlate),
       checkInTime = Value(checkInTime),
       hourlyRate = Value(hourlyRate),
       isPaid = Value(isPaid);
  static Insertable<RentalsTableData> custom({
    Expression<String>? id,
    Expression<String>? slotId,
    Expression<String>? slotLabel,
    Expression<String>? licensePlate,
    Expression<String>? vehicleDetails,
    Expression<String>? customerPhone,
    Expression<DateTime>? checkInTime,
    Expression<DateTime>? checkOutTime,
    Expression<double>? hourlyRate,
    Expression<double>? totalAmount,
    Expression<bool>? isPaid,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (slotId != null) 'slot_id': slotId,
      if (slotLabel != null) 'slot_label': slotLabel,
      if (licensePlate != null) 'license_plate': licensePlate,
      if (vehicleDetails != null) 'vehicle_details': vehicleDetails,
      if (customerPhone != null) 'customer_phone': customerPhone,
      if (checkInTime != null) 'check_in_time': checkInTime,
      if (checkOutTime != null) 'check_out_time': checkOutTime,
      if (hourlyRate != null) 'hourly_rate': hourlyRate,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (isPaid != null) 'is_paid': isPaid,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RentalsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? slotId,
    Value<String>? slotLabel,
    Value<String>? licensePlate,
    Value<String?>? vehicleDetails,
    Value<String?>? customerPhone,
    Value<DateTime>? checkInTime,
    Value<DateTime?>? checkOutTime,
    Value<double>? hourlyRate,
    Value<double?>? totalAmount,
    Value<bool>? isPaid,
    Value<int>? rowid,
  }) {
    return RentalsTableCompanion(
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
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (slotId.present) {
      map['slot_id'] = Variable<String>(slotId.value);
    }
    if (slotLabel.present) {
      map['slot_label'] = Variable<String>(slotLabel.value);
    }
    if (licensePlate.present) {
      map['license_plate'] = Variable<String>(licensePlate.value);
    }
    if (vehicleDetails.present) {
      map['vehicle_details'] = Variable<String>(vehicleDetails.value);
    }
    if (customerPhone.present) {
      map['customer_phone'] = Variable<String>(customerPhone.value);
    }
    if (checkInTime.present) {
      map['check_in_time'] = Variable<DateTime>(checkInTime.value);
    }
    if (checkOutTime.present) {
      map['check_out_time'] = Variable<DateTime>(checkOutTime.value);
    }
    if (hourlyRate.present) {
      map['hourly_rate'] = Variable<double>(hourlyRate.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (isPaid.present) {
      map['is_paid'] = Variable<bool>(isPaid.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RentalsTableCompanion(')
          ..write('id: $id, ')
          ..write('slotId: $slotId, ')
          ..write('slotLabel: $slotLabel, ')
          ..write('licensePlate: $licensePlate, ')
          ..write('vehicleDetails: $vehicleDetails, ')
          ..write('customerPhone: $customerPhone, ')
          ..write('checkInTime: $checkInTime, ')
          ..write('checkOutTime: $checkOutTime, ')
          ..write('hourlyRate: $hourlyRate, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('isPaid: $isPaid, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$ParkingDatabase extends GeneratedDatabase {
  _$ParkingDatabase(QueryExecutor e) : super(e);
  $ParkingDatabaseManager get managers => $ParkingDatabaseManager(this);
  late final $ParkingSlotsTableTable parkingSlotsTable =
      $ParkingSlotsTableTable(this);
  late final $RentalsTableTable rentalsTable = $RentalsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    parkingSlotsTable,
    rentalsTable,
  ];
}

typedef $$ParkingSlotsTableTableCreateCompanionBuilder =
    ParkingSlotsTableCompanion Function({
      required String id,
      required String label,
      required double x,
      required double y,
      required double width,
      required double height,
      required double rotation,
      required String status,
      required String type,
      Value<double?> hourlyRate,
      Value<String?> activeRentalId,
      Value<int> rowid,
    });
typedef $$ParkingSlotsTableTableUpdateCompanionBuilder =
    ParkingSlotsTableCompanion Function({
      Value<String> id,
      Value<String> label,
      Value<double> x,
      Value<double> y,
      Value<double> width,
      Value<double> height,
      Value<double> rotation,
      Value<String> status,
      Value<String> type,
      Value<double?> hourlyRate,
      Value<String?> activeRentalId,
      Value<int> rowid,
    });

class $$ParkingSlotsTableTableFilterComposer
    extends Composer<_$ParkingDatabase, $ParkingSlotsTableTable> {
  $$ParkingSlotsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get x => $composableBuilder(
    column: $table.x,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get y => $composableBuilder(
    column: $table.y,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get width => $composableBuilder(
    column: $table.width,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rotation => $composableBuilder(
    column: $table.rotation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get hourlyRate => $composableBuilder(
    column: $table.hourlyRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get activeRentalId => $composableBuilder(
    column: $table.activeRentalId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ParkingSlotsTableTableOrderingComposer
    extends Composer<_$ParkingDatabase, $ParkingSlotsTableTable> {
  $$ParkingSlotsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get x => $composableBuilder(
    column: $table.x,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get y => $composableBuilder(
    column: $table.y,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get width => $composableBuilder(
    column: $table.width,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rotation => $composableBuilder(
    column: $table.rotation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get hourlyRate => $composableBuilder(
    column: $table.hourlyRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get activeRentalId => $composableBuilder(
    column: $table.activeRentalId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ParkingSlotsTableTableAnnotationComposer
    extends Composer<_$ParkingDatabase, $ParkingSlotsTableTable> {
  $$ParkingSlotsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<double> get x =>
      $composableBuilder(column: $table.x, builder: (column) => column);

  GeneratedColumn<double> get y =>
      $composableBuilder(column: $table.y, builder: (column) => column);

  GeneratedColumn<double> get width =>
      $composableBuilder(column: $table.width, builder: (column) => column);

  GeneratedColumn<double> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<double> get rotation =>
      $composableBuilder(column: $table.rotation, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<double> get hourlyRate => $composableBuilder(
    column: $table.hourlyRate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get activeRentalId => $composableBuilder(
    column: $table.activeRentalId,
    builder: (column) => column,
  );
}

class $$ParkingSlotsTableTableTableManager
    extends
        RootTableManager<
          _$ParkingDatabase,
          $ParkingSlotsTableTable,
          ParkingSlotsTableData,
          $$ParkingSlotsTableTableFilterComposer,
          $$ParkingSlotsTableTableOrderingComposer,
          $$ParkingSlotsTableTableAnnotationComposer,
          $$ParkingSlotsTableTableCreateCompanionBuilder,
          $$ParkingSlotsTableTableUpdateCompanionBuilder,
          (
            ParkingSlotsTableData,
            BaseReferences<
              _$ParkingDatabase,
              $ParkingSlotsTableTable,
              ParkingSlotsTableData
            >,
          ),
          ParkingSlotsTableData,
          PrefetchHooks Function()
        > {
  $$ParkingSlotsTableTableTableManager(
    _$ParkingDatabase db,
    $ParkingSlotsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ParkingSlotsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ParkingSlotsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ParkingSlotsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<double> x = const Value.absent(),
                Value<double> y = const Value.absent(),
                Value<double> width = const Value.absent(),
                Value<double> height = const Value.absent(),
                Value<double> rotation = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<double?> hourlyRate = const Value.absent(),
                Value<String?> activeRentalId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ParkingSlotsTableCompanion(
                id: id,
                label: label,
                x: x,
                y: y,
                width: width,
                height: height,
                rotation: rotation,
                status: status,
                type: type,
                hourlyRate: hourlyRate,
                activeRentalId: activeRentalId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String label,
                required double x,
                required double y,
                required double width,
                required double height,
                required double rotation,
                required String status,
                required String type,
                Value<double?> hourlyRate = const Value.absent(),
                Value<String?> activeRentalId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ParkingSlotsTableCompanion.insert(
                id: id,
                label: label,
                x: x,
                y: y,
                width: width,
                height: height,
                rotation: rotation,
                status: status,
                type: type,
                hourlyRate: hourlyRate,
                activeRentalId: activeRentalId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ParkingSlotsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$ParkingDatabase,
      $ParkingSlotsTableTable,
      ParkingSlotsTableData,
      $$ParkingSlotsTableTableFilterComposer,
      $$ParkingSlotsTableTableOrderingComposer,
      $$ParkingSlotsTableTableAnnotationComposer,
      $$ParkingSlotsTableTableCreateCompanionBuilder,
      $$ParkingSlotsTableTableUpdateCompanionBuilder,
      (
        ParkingSlotsTableData,
        BaseReferences<
          _$ParkingDatabase,
          $ParkingSlotsTableTable,
          ParkingSlotsTableData
        >,
      ),
      ParkingSlotsTableData,
      PrefetchHooks Function()
    >;
typedef $$RentalsTableTableCreateCompanionBuilder =
    RentalsTableCompanion Function({
      required String id,
      required String slotId,
      required String slotLabel,
      required String licensePlate,
      Value<String?> vehicleDetails,
      Value<String?> customerPhone,
      required DateTime checkInTime,
      Value<DateTime?> checkOutTime,
      required double hourlyRate,
      Value<double?> totalAmount,
      required bool isPaid,
      Value<int> rowid,
    });
typedef $$RentalsTableTableUpdateCompanionBuilder =
    RentalsTableCompanion Function({
      Value<String> id,
      Value<String> slotId,
      Value<String> slotLabel,
      Value<String> licensePlate,
      Value<String?> vehicleDetails,
      Value<String?> customerPhone,
      Value<DateTime> checkInTime,
      Value<DateTime?> checkOutTime,
      Value<double> hourlyRate,
      Value<double?> totalAmount,
      Value<bool> isPaid,
      Value<int> rowid,
    });

class $$RentalsTableTableFilterComposer
    extends Composer<_$ParkingDatabase, $RentalsTableTable> {
  $$RentalsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get slotId => $composableBuilder(
    column: $table.slotId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get slotLabel => $composableBuilder(
    column: $table.slotLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get licensePlate => $composableBuilder(
    column: $table.licensePlate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vehicleDetails => $composableBuilder(
    column: $table.vehicleDetails,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerPhone => $composableBuilder(
    column: $table.customerPhone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get checkInTime => $composableBuilder(
    column: $table.checkInTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get checkOutTime => $composableBuilder(
    column: $table.checkOutTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get hourlyRate => $composableBuilder(
    column: $table.hourlyRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPaid => $composableBuilder(
    column: $table.isPaid,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RentalsTableTableOrderingComposer
    extends Composer<_$ParkingDatabase, $RentalsTableTable> {
  $$RentalsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slotId => $composableBuilder(
    column: $table.slotId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slotLabel => $composableBuilder(
    column: $table.slotLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get licensePlate => $composableBuilder(
    column: $table.licensePlate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vehicleDetails => $composableBuilder(
    column: $table.vehicleDetails,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerPhone => $composableBuilder(
    column: $table.customerPhone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get checkInTime => $composableBuilder(
    column: $table.checkInTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get checkOutTime => $composableBuilder(
    column: $table.checkOutTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get hourlyRate => $composableBuilder(
    column: $table.hourlyRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPaid => $composableBuilder(
    column: $table.isPaid,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RentalsTableTableAnnotationComposer
    extends Composer<_$ParkingDatabase, $RentalsTableTable> {
  $$RentalsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get slotId =>
      $composableBuilder(column: $table.slotId, builder: (column) => column);

  GeneratedColumn<String> get slotLabel =>
      $composableBuilder(column: $table.slotLabel, builder: (column) => column);

  GeneratedColumn<String> get licensePlate => $composableBuilder(
    column: $table.licensePlate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get vehicleDetails => $composableBuilder(
    column: $table.vehicleDetails,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customerPhone => $composableBuilder(
    column: $table.customerPhone,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get checkInTime => $composableBuilder(
    column: $table.checkInTime,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get checkOutTime => $composableBuilder(
    column: $table.checkOutTime,
    builder: (column) => column,
  );

  GeneratedColumn<double> get hourlyRate => $composableBuilder(
    column: $table.hourlyRate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isPaid =>
      $composableBuilder(column: $table.isPaid, builder: (column) => column);
}

class $$RentalsTableTableTableManager
    extends
        RootTableManager<
          _$ParkingDatabase,
          $RentalsTableTable,
          RentalsTableData,
          $$RentalsTableTableFilterComposer,
          $$RentalsTableTableOrderingComposer,
          $$RentalsTableTableAnnotationComposer,
          $$RentalsTableTableCreateCompanionBuilder,
          $$RentalsTableTableUpdateCompanionBuilder,
          (
            RentalsTableData,
            BaseReferences<
              _$ParkingDatabase,
              $RentalsTableTable,
              RentalsTableData
            >,
          ),
          RentalsTableData,
          PrefetchHooks Function()
        > {
  $$RentalsTableTableTableManager(
    _$ParkingDatabase db,
    $RentalsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RentalsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RentalsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RentalsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> slotId = const Value.absent(),
                Value<String> slotLabel = const Value.absent(),
                Value<String> licensePlate = const Value.absent(),
                Value<String?> vehicleDetails = const Value.absent(),
                Value<String?> customerPhone = const Value.absent(),
                Value<DateTime> checkInTime = const Value.absent(),
                Value<DateTime?> checkOutTime = const Value.absent(),
                Value<double> hourlyRate = const Value.absent(),
                Value<double?> totalAmount = const Value.absent(),
                Value<bool> isPaid = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RentalsTableCompanion(
                id: id,
                slotId: slotId,
                slotLabel: slotLabel,
                licensePlate: licensePlate,
                vehicleDetails: vehicleDetails,
                customerPhone: customerPhone,
                checkInTime: checkInTime,
                checkOutTime: checkOutTime,
                hourlyRate: hourlyRate,
                totalAmount: totalAmount,
                isPaid: isPaid,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String slotId,
                required String slotLabel,
                required String licensePlate,
                Value<String?> vehicleDetails = const Value.absent(),
                Value<String?> customerPhone = const Value.absent(),
                required DateTime checkInTime,
                Value<DateTime?> checkOutTime = const Value.absent(),
                required double hourlyRate,
                Value<double?> totalAmount = const Value.absent(),
                required bool isPaid,
                Value<int> rowid = const Value.absent(),
              }) => RentalsTableCompanion.insert(
                id: id,
                slotId: slotId,
                slotLabel: slotLabel,
                licensePlate: licensePlate,
                vehicleDetails: vehicleDetails,
                customerPhone: customerPhone,
                checkInTime: checkInTime,
                checkOutTime: checkOutTime,
                hourlyRate: hourlyRate,
                totalAmount: totalAmount,
                isPaid: isPaid,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RentalsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$ParkingDatabase,
      $RentalsTableTable,
      RentalsTableData,
      $$RentalsTableTableFilterComposer,
      $$RentalsTableTableOrderingComposer,
      $$RentalsTableTableAnnotationComposer,
      $$RentalsTableTableCreateCompanionBuilder,
      $$RentalsTableTableUpdateCompanionBuilder,
      (
        RentalsTableData,
        BaseReferences<_$ParkingDatabase, $RentalsTableTable, RentalsTableData>,
      ),
      RentalsTableData,
      PrefetchHooks Function()
    >;

class $ParkingDatabaseManager {
  final _$ParkingDatabase _db;
  $ParkingDatabaseManager(this._db);
  $$ParkingSlotsTableTableTableManager get parkingSlotsTable =>
      $$ParkingSlotsTableTableTableManager(_db, _db.parkingSlotsTable);
  $$RentalsTableTableTableManager get rentalsTable =>
      $$RentalsTableTableTableManager(_db, _db.rentalsTable);
}
