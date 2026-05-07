import 'package:property256/core/repository/in_memory_property_datasource.dart';
import 'package:property256/core/models/property_entity.dart';
import 'package:property256/core/repository/property_repository.dart';

class PropertyRepositoryImpl implements PropertyRepository {
  const PropertyRepositoryImpl({required this.dataSource});

  final InMemoryPropertyDataSource dataSource;

  @override
  Future<List<PropertyEntity>> getProperties() async {
    try {
      final List<PropertyEntity> properties = (await dataSource.getProperties())
          .map((final property) => property.toEntity())
          .toList(growable: false);

      return properties;
    } catch (error) {
      // print('Failed to load properties: $error');
      return <PropertyEntity>[];
    }
  }

  @override
  Future<PropertyEntity?> getPropertyById({required final String id}) async {
    if (id.isEmpty) {
      return null;
    }

    final List<PropertyEntity> properties = await getProperties();
    for (final PropertyEntity property in properties) {
      if (property.id == id) {
        return property;
      }
    }

    return null;
  }
}
