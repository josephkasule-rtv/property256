import 'package:property256/features/property/data/datasources/in_memory_property_datasource.dart';
import 'package:property256/features/property/domain/entities/property_entity.dart';
import 'package:property256/features/property/domain/repositories/property_repository.dart';

class PropertyRepositoryImpl implements PropertyRepository {
  const PropertyRepositoryImpl({required this.dataSource});

  final InMemoryPropertyDataSource dataSource;

  @override
  Future<List<PropertyEntity>> getProperties() async {
    final List<PropertyEntity> properties = (await dataSource.getProperties())
        .map((final property) => property.toEntity())
        .toList(growable: false);

    return properties;
  }

  @override
  Future<PropertyEntity?> getPropertyById({required final String id}) async {
    final List<PropertyEntity> properties = await getProperties();

    for (final PropertyEntity property in properties) {
      if (property.id == id) {
        return property;
      }
    }

    return null;
  }
}
