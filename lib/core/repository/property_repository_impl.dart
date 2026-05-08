import 'package:property256/core/database/app_database.dart';
import 'package:property256/core/database/database_constants.dart';
import 'package:property256/core/models/property_entity.dart';
import 'package:property256/core/models/property_model.dart';
import 'package:property256/core/models/unit_entity.dart';
import 'package:property256/core/models/unit_model.dart';
import 'package:property256/core/repository/property_repository.dart';
import 'package:sqflite/sqflite.dart';

class PropertyRepositoryImpl implements PropertyRepository {
  const PropertyRepositoryImpl();

  @override
  Future<List<PropertyEntity>> getProperties() async {
    final Database db = await AppDatabase.instance.database;
    final List<Map<String, Object?>> rows = await db.query(
      PropertiesTable.tableName,
      orderBy: '${PropertiesTable.listedAt} DESC',
    );

    return rows
        .map(
          (final Map<String, Object?> row) =>
              PropertyModel.fromMap(row).toEntity(),
        )
        .toList(growable: false);
  }

  @override
  Future<PropertyEntity?> getPropertyById({required final String id}) async {
    if (id.isEmpty) {
      return null;
    }

    final Database db = await AppDatabase.instance.database;
    final List<Map<String, Object?>> rows = await db.query(
      PropertiesTable.tableName,
      where: '${PropertiesTable.id} = ?',
      whereArgs: <Object>[id],
      limit: 1,
    );

    if (rows.isEmpty) {
      return null;
    }

    return PropertyModel.fromMap(rows.first).toEntity();
  }

  @override
  Future<void> createProperty({required final PropertyEntity property}) async {
    final Database db = await AppDatabase.instance.database;
    final PropertyModel propertyModel = PropertyModel.fromEntity(property);

    await db.insert(
      PropertiesTable.tableName,
      propertyModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  @override
  Future<List<UnitEntity>> getUnitsByPropertyId({
    required final String propertyId,
  }) async {
    if (propertyId.isEmpty) {
      return <UnitEntity>[];
    }

    final Database db = await AppDatabase.instance.database;
    final List<Map<String, Object?>> rows = await db.query(
      UnitsTable.tableName,
      where: '${UnitsTable.propertyId} = ?',
      whereArgs: <Object>[propertyId],
      orderBy: '${UnitsTable.createdAt} DESC',
    );

    return rows
        .map(
          (final Map<String, Object?> row) => UnitModel.fromMap(row).toEntity(),
        )
        .toList(growable: false);
  }

  @override
  Future<void> createUnit({required final UnitEntity unit}) async {
    final Database db = await AppDatabase.instance.database;
    final UnitModel unitModel = UnitModel.fromEntity(unit);

    await db.insert(
      UnitsTable.tableName,
      unitModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }
}
