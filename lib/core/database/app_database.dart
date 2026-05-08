import 'package:path/path.dart' as path;
import 'package:property256/core/database/database_constants.dart';
import 'package:property256/core/util/sqlite_column_values.dart';
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
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(final Database db, final int version) async {
    await db.execute('''
CREATE TABLE ${PropertiesTable.tableName} (
  ${PropertiesTable.id} TEXT NOT NULL PRIMARY KEY,
  ${PropertiesTable.userId} TEXT NOT NULL,
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

    await _seedProperties(db: db);

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

  Future<void> _onUpgrade(
    final Database db,
    final int oldVersion,
    final int newVersion,
  ) async {
    if (oldVersion < 2) {
      await db.execute(
        'ALTER TABLE ${PropertiesTable.tableName} ADD COLUMN ${PropertiesTable.userId} TEXT NOT NULL DEFAULT "static-user-001";',
      );
      await _seedProperties(db: db);
    }
  }

  Future<void> _seedProperties({required final Database db}) async {
    final List<Map<String, Object?>> seedRows = <Map<String, Object?>>[
      <String, Object?>{
        PropertiesTable.id: 'kololo-001',
        PropertiesTable.userId: 'static-user-001',
        PropertiesTable.title: 'Modern 3-Bedroom Apartment',
        PropertiesTable.location: 'Kololo, Kampala',
        PropertiesTable.address: 'Wampewo Avenue, Kololo',
        PropertiesTable.pricePerMonth: 4200000,
        PropertiesTable.bedrooms: 3,
        PropertiesTable.bathrooms: 2,
        PropertiesTable.squareMeters: 138,
        PropertiesTable.imageUrl:
            'https://images.unsplash.com/photo-1494526585095-c41746248156?w=1200',
        PropertiesTable.description:
            'Well-lit apartment close to embassies, shopping centers, and major roads.',
        PropertiesTable.isAvailable: sqliteBoolToColumn(true),
        PropertiesTable.listedAt: sqliteDateTimeToColumn(DateTime(2026, 4, 10)),
      },
      <String, Object?>{
        PropertiesTable.id: 'ntinda-002',
        PropertiesTable.userId: 'static-user-001',
        PropertiesTable.title: 'Family Home with Garden',
        PropertiesTable.location: 'Ntinda, Kampala',
        PropertiesTable.address: 'Ntinda Road, Kampala',
        PropertiesTable.pricePerMonth: 3000000,
        PropertiesTable.bedrooms: 4,
        PropertiesTable.bathrooms: 3,
        PropertiesTable.squareMeters: 185,
        PropertiesTable.imageUrl:
            'https://images.unsplash.com/photo-1448630360428-65456885c650?w=1200',
        PropertiesTable.description:
            'Spacious standalone home with parking, compound, and a secure neighborhood.',
        PropertiesTable.isAvailable: sqliteBoolToColumn(true),
        PropertiesTable.listedAt: sqliteDateTimeToColumn(DateTime(2026, 3, 28)),
      },
      <String, Object?>{
        PropertiesTable.id: 'najjera-003',
        PropertiesTable.userId: 'static-user-001',
        PropertiesTable.title: 'Budget 2-Bedroom Rental',
        PropertiesTable.location: 'Najjera, Kampala',
        PropertiesTable.address: 'Kira Road, Najjera',
        PropertiesTable.pricePerMonth: 1400000,
        PropertiesTable.bedrooms: 2,
        PropertiesTable.bathrooms: 1,
        PropertiesTable.squareMeters: 78,
        PropertiesTable.imageUrl:
            'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=1200',
        PropertiesTable.description:
            'Affordable option with easy access to transport and neighborhood amenities.',
        PropertiesTable.isAvailable: sqliteBoolToColumn(false),
        PropertiesTable.listedAt: sqliteDateTimeToColumn(DateTime(2026, 2, 14)),
      },
    ];

    for (final Map<String, Object?> row in seedRows) {
      await db.insert(
        PropertiesTable.tableName,
        row,
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }
}
