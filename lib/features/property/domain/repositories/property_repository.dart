import 'package:property256/features/property/domain/entities/property_entity.dart';

abstract interface class PropertyRepository {
  Future<List<PropertyEntity>> getProperties();

  Future<PropertyEntity?> getPropertyById({required String id});
}
