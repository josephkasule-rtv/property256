import 'package:equatable/equatable.dart';

class UnitEntity extends Equatable {
  const UnitEntity({
    required this.id,
    required this.propertyId,
    required this.name,
    required this.rentAmount,
    required this.isOccupied,
    required this.createdAt,
    this.bedrooms = 0,
    this.bathrooms = 0,
  });

  final String id;
  final String propertyId;
  final String name;
  final int rentAmount;
  final bool isOccupied;
  final DateTime createdAt;
  final int bedrooms;
  final int bathrooms;

  @override
  List<Object> get props => <Object>[
    id,
    propertyId,
    name,
    rentAmount,
    isOccupied,
    createdAt,
    bedrooms,
    bathrooms,
  ];
}
