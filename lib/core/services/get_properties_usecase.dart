import 'package:property256/core/models/property_entity.dart';
import 'package:property256/core/repository/property_repository.dart';

class GetPropertiesUseCase {
  const GetPropertiesUseCase({required this.repository});

  final PropertyRepository repository;

  Future<List<PropertyEntity>> call() {
    return repository.getProperties();
  }
}
