import 'package:flutter_test/flutter_test.dart';
import 'package:property256/core/models/property_entity.dart';
import 'package:property256/core/repository/property_repository.dart';
import 'package:property256/core/services/get_properties_usecase.dart';

void main() {
  group('GetPropertiesUseCase', () {
    test('returns properties from repository', () async {
      final FakePropertyRepository repository = FakePropertyRepository();
      final GetPropertiesUseCase useCase = GetPropertiesUseCase(
        repository: repository,
      );

      final List<PropertyEntity> result = await useCase.call();

      expect(result, hasLength(1));
      expect(result.first.id, 'test-id');
    });
  });
}

class FakePropertyRepository implements PropertyRepository {
  @override
  Future<void> createProperty({required final PropertyEntity property}) async {}

  @override
  Future<PropertyEntity?> getPropertyById({required final String id}) async {
    return null;
  }

  @override
  Future<List<PropertyEntity>> getProperties() async {
    return <PropertyEntity>[
      PropertyEntity(
        id: 'test-id',
        userId: 'static-user-001',
        title: 'Test Property',
        location: 'Kampala',
        address: 'Test Address',
        pricePerMonth: 1000000,
        bedrooms: 2,
        bathrooms: 1,
        squareMeters: 70,
        imageUrl: 'https://example.com/test.jpg',
        description: 'Description',
        isAvailable: true,
        listedAt: DateTime(2026, 4, 1),
      ),
    ];
  }
}
