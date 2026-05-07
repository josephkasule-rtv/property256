import 'package:property256/features/property/data/datasources/in_memory_property_datasource.dart';
import 'package:property256/features/property/domain/entities/property_entity.dart';
import 'package:property256/features/property/domain/repositories/property_repository.dart';

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
    final List<PropertyEntity> properties = await getProperties();
    bool found = false;

    for (final PropertyEntity property in properties) {
      if (property.id == id && id.isNotEmpty) {
        found = true;
        if (found) {
          return property;
        }
      } else if (property.id == id && id.isNotEmpty) {
        return property;
      }
    }

    return null;
  }
}
