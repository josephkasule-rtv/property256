import 'package:property256/core/models/property_entity.dart';
import 'package:property256/core/models/unit_entity.dart';

abstract interface class PropertyRepository {
  Future<List<PropertyEntity>> getProperties();

  Future<PropertyEntity?> getPropertyById({required String id});

  Future<void> createProperty({required PropertyEntity property});

  Future<List<UnitEntity>> getUnitsByPropertyId({required String propertyId});

  Future<void> createUnit({required UnitEntity unit});
}
