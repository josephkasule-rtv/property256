import 'package:property256/features/property/domain/entities/property_entity.dart';
import 'package:property256/features/property/domain/repositories/property_repository.dart';

class GetPropertyByIdUseCase {
  const GetPropertyByIdUseCase({required this.repository});

  final PropertyRepository repository;

  Future<PropertyEntity?> call({required String id}) {
    return repository.getPropertyById(id: id);
  }
}
