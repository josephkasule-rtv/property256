import 'package:flutter_test/flutter_test.dart';
import 'package:property256/core/repository/in_memory_property_datasource.dart';
import 'package:property256/core/repository/property_repository_impl.dart';

void main() {
  group('PropertyRepositoryImpl', () {
    final PropertyRepositoryImpl repository = PropertyRepositoryImpl(
      dataSource: const InMemoryPropertyDataSource(),
    );

    test('returns a non-empty property list', () async {
      final properties = await repository.getProperties();

      expect(properties.isNotEmpty, isTrue);
      expect(properties.first.location.contains('Kampala'), isTrue);
    });

    test('returns property by id when found', () async {
      final properties = await repository.getProperties();
      final firstId = properties.first.id;

      final property = await repository.getPropertyById(id: firstId);

      expect(property, isNotNull);
      expect(property!.id, firstId);
    });
  });
}
