import 'package:equatable/equatable.dart';
import 'package:property256/features/property/domain/entities/property_entity.dart';

class PropertyModel extends Equatable {
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
