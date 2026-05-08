import 'package:property256/core/models/unit_entity.dart';
import 'package:property256/core/repository/property_repository.dart';

class GetUnitsByPropertyUseCase {
  const GetUnitsByPropertyUseCase({required this.repository});

  final PropertyRepository repository;

  Future<List<UnitEntity>> call({required final String propertyId}) {
    return repository.getUnitsByPropertyId(propertyId: propertyId);
  }
}
