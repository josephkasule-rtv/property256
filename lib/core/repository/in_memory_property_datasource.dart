import 'package:property256/core/models/property_model.dart';

class InMemoryPropertyDataSource {
  const InMemoryPropertyDataSource();

  Future<List<PropertyModel>> getProperties() async {
    return _properties;
  }
}

final List<PropertyModel> _properties = <PropertyModel>[
  PropertyModel(
    id: 'kololo-001',
    userId: 'static-user-001',
    title: 'Modern 3-Bedroom Apartment',
    location: 'Kololo, Kampala',
    address: 'Wampewo Avenue, Kololo',
    pricePerMonth: 4200000,
    bedrooms: 3,
    bathrooms: 2,
    squareMeters: 138,
    imageUrl:
        'https://images.unsplash.com/photo-1494526585095-c41746248156?w=1200',
    description:
        'Well-lit apartment close to embassies, shopping centers, and major roads.',
    isAvailable: true,
    listedAt: DateTime(2026, 4, 10),
  ),
];
