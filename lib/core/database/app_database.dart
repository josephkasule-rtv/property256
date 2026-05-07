import 'package:path/path.dart' as path;
import 'package:property256/core/database/database_constants.dart';
import 'package:sqflite/sqflite.dart';

/// Opens the app SQLite database and applies schema on first launch.
final class AppDatabase {
  AppDatabase._();

  static final AppDatabase instance = AppDatabase._();

  Database? _database;

  Future<Database> get database async {
    _database ??= await _openDatabase();
    return _database!;
  }

  /// Ensures the database file exists and schema is applied. Call from [main].
  Future<void> initialize() async {
    await database;
  }

  Future<Database> _openDatabase() async {
    final String dbFolderPath = await getDatabasesPath();
    final String dbPath = path.join(dbFolderPath, DbConfig.fileName);

    return openDatabase(
      dbPath,
      version: DbConfig.version,
      onConfigure: (final Database db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(final Database db, final int version) async {
    await db.execute('''
CREATE TABLE ${PropertiesTable.tableName} (
  ${PropertiesTable.id} TEXT NOT NULL PRIMARY KEY,
  ${PropertiesTable.title} TEXT NOT NULL,
  ${PropertiesTable.location} TEXT NOT NULL,
  ${PropertiesTable.address} TEXT NOT NULL,
  ${PropertiesTable.pricePerMonth} INTEGER NOT NULL,
  ${PropertiesTable.bedrooms} INTEGER NOT NULL,
  ${PropertiesTable.bathrooms} INTEGER NOT NULL,
  ${PropertiesTable.squareMeters} REAL NOT NULL,
  ${PropertiesTable.imageUrl} TEXT NOT NULL,
  ${PropertiesTable.description} TEXT NOT NULL,
  ${PropertiesTable.isAvailable} INTEGER NOT NULL,
  ${PropertiesTable.listedAt} TEXT NOT NULL
);
''');

    await db.execute('''
CREATE TABLE ${UnitsTable.tableName} (
  ${UnitsTable.id} TEXT NOT NULL PRIMARY KEY,
  ${UnitsTable.propertyId} TEXT NOT NULL,
  ${UnitsTable.unitName} TEXT NOT NULL,
  ${UnitsTable.bedrooms} INTEGER NOT NULL,
  ${UnitsTable.bathrooms} INTEGER NOT NULL,
  ${UnitsTable.rentAmount} INTEGER NOT NULL,
  ${UnitsTable.isOccupied} INTEGER NOT NULL,
  ${UnitsTable.createdAt} TEXT NOT NULL,
  FOREIGN KEY (${UnitsTable.propertyId})
    REFERENCES ${PropertiesTable.tableName} (${PropertiesTable.id})
    ON DELETE CASCADE
);
''');

    await db.execute('''
CREATE TABLE ${TenantsTable.tableName} (
  ${TenantsTable.id} TEXT NOT NULL PRIMARY KEY,
  ${TenantsTable.unitId} TEXT NOT NULL,
  ${TenantsTable.fullName} TEXT NOT NULL,
  ${TenantsTable.phone} TEXT NOT NULL,
  ${TenantsTable.email} TEXT,
  ${TenantsTable.moveInDate} TEXT,
  ${TenantsTable.isActive} INTEGER NOT NULL,
  FOREIGN KEY (${TenantsTable.unitId})
    REFERENCES ${UnitsTable.tableName} (${UnitsTable.id})
    ON DELETE CASCADE
);
''');

    await db.execute('''
CREATE TABLE ${PaymentsTable.tableName} (
  ${PaymentsTable.id} TEXT NOT NULL PRIMARY KEY,
  ${PaymentsTable.tenantId} TEXT NOT NULL,
  ${PaymentsTable.amount} INTEGER NOT NULL,
  ${PaymentsTable.paidAt} TEXT NOT NULL,
  ${PaymentsTable.periodMonth} TEXT NOT NULL,
  ${PaymentsTable.method} TEXT NOT NULL,
  ${PaymentsTable.reference} TEXT,
  FOREIGN KEY (${PaymentsTable.tenantId})
    REFERENCES ${TenantsTable.tableName} (${TenantsTable.id})
    ON DELETE CASCADE
);
''');

    await db.execute('''
CREATE TABLE ${ExpensesTable.tableName} (
  ${ExpensesTable.id} TEXT NOT NULL PRIMARY KEY,
  ${ExpensesTable.propertyId} TEXT NOT NULL,
  ${ExpensesTable.category} TEXT NOT NULL,
  ${ExpensesTable.amount} INTEGER NOT NULL,
  ${ExpensesTable.spentAt} TEXT NOT NULL,
  ${ExpensesTable.description} TEXT,
  FOREIGN KEY (${ExpensesTable.propertyId})
    REFERENCES ${PropertiesTable.tableName} (${PropertiesTable.id})
    ON DELETE CASCADE
);
''');

    await db.execute(
      'CREATE INDEX idx_units_property_id ON ${UnitsTable.tableName} (${UnitsTable.propertyId});',
    );
    await db.execute(
      'CREATE INDEX idx_tenants_unit_id ON ${TenantsTable.tableName} (${TenantsTable.unitId});',
    );
    await db.execute(
      'CREATE INDEX idx_payments_tenant_id ON ${PaymentsTable.tableName} (${PaymentsTable.tenantId});',
    );
    await db.execute(
      'CREATE INDEX idx_expenses_property_id ON ${ExpensesTable.tableName} (${ExpensesTable.propertyId});',
    );
  }
}
