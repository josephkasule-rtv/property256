import 'package:equatable/equatable.dart';

class PropertyEntity extends Equatable {
  const PropertyEntity({
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

  @override
  List<Object> get props => <Object>[
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
