import 'package:equatable/equatable.dart';
import 'package:property256/core/database/database_constants.dart';
import 'package:property256/core/util/sqlite_column_values.dart';
import 'package:property256/core/models/property_entity.dart';

/// Persistent representation of a property row; maps to [PropertiesTable].
final class PropertyModel extends Equatable {
  const PropertyModel({
    required this.id,
    required this.title,
    required this.location,
    required this.address,
    required this.pricePerMonth,
    required this.bedrooms,
    required this.bathrooms,
    required this.squareMeters,
    required this.imageUrl,
    required this.description,
    required this.isAvailable,
    required this.listedAt,
  });

  final String id;
  final String title;
  final String location;
  final String address;
  final int pricePerMonth;
  final int bedrooms;
  final int bathrooms;
  final double squareMeters;
  final String imageUrl;
  final String description;
  final bool isAvailable;
  final DateTime listedAt;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      PropertiesTable.id: id,
      PropertiesTable.title: title,
      PropertiesTable.location: location,
      PropertiesTable.address: address,
      PropertiesTable.pricePerMonth: pricePerMonth,
      PropertiesTable.bedrooms: bedrooms,
      PropertiesTable.bathrooms: bathrooms,
      PropertiesTable.squareMeters: squareMeters,
      PropertiesTable.imageUrl: imageUrl,
      PropertiesTable.description: description,
      PropertiesTable.isAvailable: sqliteBoolToColumn(isAvailable),
      PropertiesTable.listedAt: sqliteDateTimeToColumn(listedAt),
    };
  }

  factory PropertyModel.fromMap(final Map<String, Object?> map) {
    final String id = stringFromColumn(map[PropertiesTable.id]);
    if (id.isEmpty) {
      throw FormatException('Property id must not be empty');
    }
    return PropertyModel(
      id: id,
      title: stringFromColumn(map[PropertiesTable.title]),
      location: stringFromColumn(map[PropertiesTable.location]),
      address: stringFromColumn(map[PropertiesTable.address]),
      pricePerMonth: intFromColumn(map[PropertiesTable.pricePerMonth]),
      bedrooms: intFromColumn(map[PropertiesTable.bedrooms]),
      bathrooms: intFromColumn(map[PropertiesTable.bathrooms]),
      squareMeters: doubleFromColumn(map[PropertiesTable.squareMeters]),
      imageUrl: stringFromColumn(map[PropertiesTable.imageUrl]),
      description: stringFromColumn(map[PropertiesTable.description]),
      isAvailable: sqliteBoolFromColumn(map[PropertiesTable.isAvailable]),
      listedAt: sqliteDateTimeFromColumn(map[PropertiesTable.listedAt]),
    );
  }

  PropertyEntity toEntity() {
    return PropertyEntity(
      id: id,
      title: title,
      location: location,
      address: address,
      pricePerMonth: pricePerMonth,
      bedrooms: bedrooms,
      bathrooms: bathrooms,
      squareMeters: squareMeters,
      imageUrl: imageUrl,
      description: description,
      isAvailable: isAvailable,
      listedAt: listedAt,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    id,
    title,
    location,
    address,
    pricePerMonth,
    bedrooms,
    bathrooms,
    squareMeters,
    imageUrl,
    description,
    isAvailable,
    listedAt,
  ];
}
