import 'package:equatable/equatable.dart';
import 'package:property256/core/database/database_constants.dart';
import 'package:property256/core/util/sqlite_column_values.dart';

/// Row model for [UnitsTable] (`units`).
final class UnitModel extends Equatable {
  const UnitModel({
    required this.id,
    required this.propertyId,
    required this.name,
    required this.bedrooms,
    required this.bathrooms,
    required this.rentAmount,
    required this.isOccupied,
    required this.createdAt,
  });

  final String id;
  final String propertyId;
  final String name;
  final int bedrooms;
  final int bathrooms;
  final int rentAmount;
  final bool isOccupied;
  final DateTime createdAt;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      UnitsTable.id: id,
      UnitsTable.propertyId: propertyId,
      UnitsTable.unitName: name,
      UnitsTable.bedrooms: bedrooms,
      UnitsTable.bathrooms: bathrooms,
      UnitsTable.rentAmount: rentAmount,
      UnitsTable.isOccupied: sqliteBoolToColumn(isOccupied),
      UnitsTable.createdAt: sqliteDateTimeToColumn(createdAt),
    };
  }

  factory UnitModel.fromMap(final Map<String, Object?> map) {
    final String id = stringFromColumn(map[UnitsTable.id]);
    if (id.isEmpty) {
      throw FormatException('Unit id must not be empty');
    }
    final String propertyId = stringFromColumn(map[UnitsTable.propertyId]);
    if (propertyId.isEmpty) {
      throw FormatException('Unit propertyId must not be empty');
    }
    return UnitModel(
      id: id,
      propertyId: propertyId,
      name: stringFromColumn(map[UnitsTable.unitName]),
      bedrooms: intFromColumn(map[UnitsTable.bedrooms]),
      bathrooms: intFromColumn(map[UnitsTable.bathrooms]),
      rentAmount: intFromColumn(map[UnitsTable.rentAmount]),
      isOccupied: sqliteBoolFromColumn(map[UnitsTable.isOccupied]),
      createdAt: sqliteDateTimeFromColumn(map[UnitsTable.createdAt]),
    );
  }

  @override
  List<Object?> get props => <Object?>[
    id,
    propertyId,
    name,
    bedrooms,
    bathrooms,
    rentAmount,
    isOccupied,
    createdAt,
  ];
}
