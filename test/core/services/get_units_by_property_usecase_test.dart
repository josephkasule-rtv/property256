import 'package:flutter_test/flutter_test.dart';
import 'package:property256/core/models/property_entity.dart';
import 'package:property256/core/models/unit_entity.dart';
import 'package:property256/core/repository/property_repository.dart';
import 'package:property256/core/services/get_units_by_property_usecase.dart';

void main() {
  test('GetUnitsByPropertyUseCase returns units from repository', () async {
    final FakePropertyRepository repository = FakePropertyRepository();
    final GetUnitsByPropertyUseCase useCase = GetUnitsByPropertyUseCase(
      repository: repository,
    );

    final List<UnitEntity> result = await useCase.call(propertyId: 'property-1');

    expect(result, hasLength(1));
    expect(result.first.propertyId, 'property-1');
    expect(result.first.name, 'Unit A1');
  });
}

class FakePropertyRepository implements PropertyRepository {
  @override
  Future<void> createProperty({required final PropertyEntity property}) async {}

  @override
  Future<void> createUnit({required final UnitEntity unit}) async {}

  @override
  Future<PropertyEntity?> getPropertyById({required final String id}) async {
    return null;
  }

  @override
  Future<List<PropertyEntity>> getProperties() async {
    return <PropertyEntity>[];
  }

  @override
  Future<List<UnitEntity>> getUnitsByPropertyId({
    required final String propertyId,
  }) async {
    return <UnitEntity>[
      UnitEntity(
        id: 'unit-1',
        propertyId: propertyId,
        name: 'Unit A1',
        rentAmount: 2100000,
        isOccupied: false,
        createdAt: DateTime(2026, 4, 12),
      ),
    ];
  }
}
