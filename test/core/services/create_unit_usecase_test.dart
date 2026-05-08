import 'package:flutter_test/flutter_test.dart';
import 'package:property256/core/models/property_entity.dart';
import 'package:property256/core/models/unit_entity.dart';
import 'package:property256/core/repository/property_repository.dart';
import 'package:property256/core/services/create_unit_usecase.dart';

void main() {
  test('CreateUnitUseCase delegates create to repository', () async {
    final RecordingPropertyRepository repository = RecordingPropertyRepository();
    final CreateUnitUseCase useCase = CreateUnitUseCase(repository: repository);

    final UnitEntity unit = UnitEntity(
      id: 'unit-created-id',
      propertyId: 'property-1',
      name: 'Unit B2',
      rentAmount: 1850000,
      isOccupied: true,
      createdAt: DateTime(2026, 5, 1),
    );

    await useCase.call(unit: unit);

    expect(repository.createdUnits, hasLength(1));
    expect(repository.createdUnits.first.id, 'unit-created-id');
    expect(repository.createdUnits.first.propertyId, 'property-1');
  });
}

class RecordingPropertyRepository implements PropertyRepository {
  final List<UnitEntity> createdUnits = <UnitEntity>[];

  @override
  Future<void> createProperty({required final PropertyEntity property}) async {}

  @override
  Future<void> createUnit({required final UnitEntity unit}) async {
    createdUnits.add(unit);
  }

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
    return <UnitEntity>[];
  }
}
