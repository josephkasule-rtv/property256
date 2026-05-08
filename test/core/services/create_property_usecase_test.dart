import 'package:flutter_test/flutter_test.dart';
import 'package:property256/core/models/property_entity.dart';
import 'package:property256/core/repository/property_repository.dart';
import 'package:property256/core/services/create_property_usecase.dart';

void main() {
  test('CreatePropertyUseCase delegates create to repository', () async {
    final RecordingPropertyRepository repository = RecordingPropertyRepository();
    final CreatePropertyUseCase useCase = CreatePropertyUseCase(
      repository: repository,
    );

    final PropertyEntity property = PropertyEntity(
      id: 'created-id',
      userId: 'static-user-001',
      title: 'Created Property',
      location: 'Kampala',
      address: 'New Address',
      pricePerMonth: 2500000,
      bedrooms: 3,
      bathrooms: 2,
      squareMeters: 120,
      imageUrl: 'https://example.com/new.jpg',
      description: 'Created from test',
      isAvailable: true,
      listedAt: DateTime(2026, 5, 1),
    );

    await useCase.call(property: property);

    expect(repository.createdProperties, hasLength(1));
    expect(repository.createdProperties.first.id, 'created-id');
  });
}

class RecordingPropertyRepository implements PropertyRepository {
  final List<PropertyEntity> createdProperties = <PropertyEntity>[];

  @override
  Future<void> createProperty({required final PropertyEntity property}) async {
    createdProperties.add(property);
  }

  @override
  Future<PropertyEntity?> getPropertyById({required final String id}) async {
    return null;
  }

  @override
  Future<List<PropertyEntity>> getProperties() async {
    return <PropertyEntity>[];
  }
}
