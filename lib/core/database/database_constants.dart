/// Names and version for the local SQLite database.
abstract final class DbConfig {
  static const String fileName = 'property256.db';

  /// Bump when schema changes; add `onUpgrade` in [AppDatabase].
  static const int version = 2;
}

/// `properties` table and columns.
abstract final class PropertiesTable {
  static const String tableName = 'properties';

  static const String id = 'id';
  static const String userId = 'user_id';
  static const String title = 'title';
  static const String location = 'location';
  static const String address = 'address';
  static const String pricePerMonth = 'price_per_month';
  static const String bedrooms = 'bedrooms';
  static const String bathrooms = 'bathrooms';
  static const String squareMeters = 'square_meters';
  static const String imageUrl = 'image_url';
  static const String description = 'description';
  static const String isAvailable = 'is_available';
  static const String listedAt = 'listed_at';
}

/// `units` table and columns.
abstract final class UnitsTable {
  static const String tableName = 'units';

  static const String id = 'id';
  static const String propertyId = 'property_id';
  static const String unitName = 'name';
  static const String bedrooms = 'bedrooms';
  static const String bathrooms = 'bathrooms';
  static const String rentAmount = 'rent_amount';
  static const String isOccupied = 'is_occupied';
  static const String createdAt = 'created_at';
}

/// `tenants` table and columns.
abstract final class TenantsTable {
  static const String tableName = 'tenants';

  static const String id = 'id';
  static const String unitId = 'unit_id';
  static const String fullName = 'full_name';
  static const String phone = 'phone';
  static const String email = 'email';
  static const String moveInDate = 'move_in_date';
  static const String isActive = 'is_active';
}

/// `payments` table and columns.
abstract final class PaymentsTable {
  static const String tableName = 'payments';

  static const String id = 'id';
  static const String tenantId = 'tenant_id';
  static const String amount = 'amount';
  static const String paidAt = 'paid_at';
  static const String periodMonth = 'period_month';
  static const String method = 'method';
  static const String reference = 'reference';
}

/// `expenses` table and columns.
abstract final class ExpensesTable {
  static const String tableName = 'expenses';

  static const String id = 'id';
  static const String propertyId = 'property_id';
  static const String category = 'category';
  static const String amount = 'amount';
  static const String spentAt = 'spent_at';
  static const String description = 'description';
}
