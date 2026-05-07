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
  PropertyModel(
    id: 'ntinda-002',
    title: 'Family Home with Garden',
    location: 'Ntinda, Kampala',
    address: 'Ntinda Road, Kampala',
    pricePerMonth: 3000000,
    bedrooms: 4,
    bathrooms: 3,
    squareMeters: 185,
    imageUrl:
        'https://images.unsplash.com/photo-1448630360428-65456885c650?w=1200',
    description:
        'Spacious standalone home with parking, compound, and a secure neighborhood.',
    isAvailable: true,
    listedAt: DateTime(2026, 3, 28),
  ),
  PropertyModel(
    id: 'najjera-003',
    title: 'Budget 2-Bedroom Rental',
    location: 'Najjera, Kampala',
    address: 'Kira Road, Najjera',
    pricePerMonth: 1400000,
    bedrooms: 2,
    bathrooms: 1,
    squareMeters: 78,
    imageUrl:
        'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=1200',
    description:
        'Affordable option with easy access to transport and neighborhood amenities.',
    isAvailable: false,
    listedAt: DateTime(2026, 2, 14),
  ),
];
