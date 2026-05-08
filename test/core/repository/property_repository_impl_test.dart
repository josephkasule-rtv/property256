import 'package:flutter_test/flutter_test.dart';
import 'package:property256/core/database/app_database.dart';
import 'package:property256/core/models/property_entity.dart';
import 'package:property256/core/repository/property_repository_impl.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  group('PropertyRepositoryImpl', () {
    final PropertyRepositoryImpl repository = PropertyRepositoryImpl();

    setUpAll(() async {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
      await AppDatabase.instance.initialize();
    });

    test('returns a non-empty property list', () async {
      final List<PropertyEntity> properties = await repository.getProperties();

      expect(properties.isNotEmpty, isTrue);
      expect(
        properties.any((final PropertyEntity property) => property.userId.isNotEmpty),
        isTrue,
      );
    });

    test('returns property by id when found', () async {
      final List<PropertyEntity> properties = await repository.getProperties();
      final String firstId = properties.first.id;

      final PropertyEntity? property = await repository.getPropertyById(
        id: firstId,
      );

      expect(property, isNotNull);
      expect(property!.id, firstId);
    });

    test('creates a property and retrieves it', () async {
      final String id = 'test-${DateTime.now().microsecondsSinceEpoch}';
      final PropertyEntity property = PropertyEntity(
        id: id,
        userId: 'static-user-001',
        title: 'Repo Test Property',
        location: 'Kampala',
        address: 'Repo Test Address',
        pricePerMonth: 1900000,
        bedrooms: 2,
        bathrooms: 1,
        squareMeters: 80,
        imageUrl: 'https://example.com/repo-test.jpg',
        description: 'created from repository test',
        isAvailable: true,
        listedAt: DateTime.now(),
      );

      await repository.createProperty(property: property);

      final PropertyEntity? loaded = await repository.getPropertyById(id: id);

      expect(loaded, isNotNull);
      expect(loaded!.title, 'Repo Test Property');
      expect(loaded.isAvailable, isTrue);
      expect(loaded.userId, 'static-user-001');
    });
  });
}
