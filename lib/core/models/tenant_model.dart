import 'package:equatable/equatable.dart';
import 'package:property256/core/database/database_constants.dart';
import 'package:property256/core/util/sqlite_column_values.dart';

/// Row model for [TenantsTable] (`tenants`).
final class TenantModel extends Equatable {
  const TenantModel({
    required this.id,
    required this.unitId,
    required this.fullName,
    required this.phone,
    this.email,
    this.moveInDate,
    required this.isActive,
  });

  final String id;
  final String unitId;
  final String fullName;
  final String phone;
  final String? email;
  final DateTime? moveInDate;
  final bool isActive;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      TenantsTable.id: id,
      TenantsTable.unitId: unitId,
      TenantsTable.fullName: fullName,
      TenantsTable.phone: phone,
      TenantsTable.email: email,
      TenantsTable.moveInDate: moveInDate != null
          ? sqliteDateTimeToColumn(moveInDate!)
          : null,
      TenantsTable.isActive: sqliteBoolToColumn(isActive),
    };
  }

  factory TenantModel.fromMap(final Map<String, Object?> map) {
    final String id = stringFromColumn(map[TenantsTable.id]);
    if (id.isEmpty) {
      throw FormatException('Tenant id must not be empty');
    }
    final String unitId = stringFromColumn(map[TenantsTable.unitId]);
    if (unitId.isEmpty) {
      throw FormatException('Tenant unitId must not be empty');
    }
    return TenantModel(
      id: id,
      unitId: unitId,
      fullName: stringFromColumn(map[TenantsTable.fullName]),
      phone: stringFromColumn(map[TenantsTable.phone]),
      email: stringFromColumnNullable(map[TenantsTable.email]),
      moveInDate: sqliteDateTimeFromColumnNullable(
        map[TenantsTable.moveInDate],
      ),
      isActive: sqliteBoolFromColumn(map[TenantsTable.isActive]),
    );
  }

  @override
  List<Object?> get props => <Object?>[
    id,
    unitId,
    fullName,
    phone,
    email,
    moveInDate,
    isActive,
  ];
}
