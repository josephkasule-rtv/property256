import 'package:property256/core/models/unit_entity.dart';
import 'package:property256/core/repository/property_repository.dart';

class CreateUnitUseCase {
  const CreateUnitUseCase({required this.repository});

  final PropertyRepository repository;

  Future<void> call({required final UnitEntity unit}) {
    return repository.createUnit(unit: unit);
  }
}
