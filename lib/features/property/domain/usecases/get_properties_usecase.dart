import 'package:property256/features/property/domain/entities/property_entity.dart';
import 'package:property256/features/property/domain/repositories/property_repository.dart';

class GetPropertiesUseCase {
  const GetPropertiesUseCase({required this.repository});

  final PropertyRepository repository;

  Future<List<PropertyEntity>> call() {
    return repository.getProperties();
  }
}
