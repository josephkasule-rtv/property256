import 'package:property256/core/models/property_entity.dart';
import 'package:property256/core/repository/property_repository.dart';

class CreatePropertyUseCase {
  const CreatePropertyUseCase({required this.repository});

  final PropertyRepository repository;

  Future<void> call({required final PropertyEntity property}) {
    return repository.createProperty(property: property);
  }
}
