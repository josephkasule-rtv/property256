import 'package:property256/core/models/property_entity.dart';
import 'package:property256/core/repository/property_repository.dart';

class GetPropertyByIdUseCase {
  const GetPropertyByIdUseCase({required this.repository});

  final PropertyRepository repository;

  Future<PropertyEntity?> call({required String id}) {
    return repository.getPropertyById(id: id);
  }
}
