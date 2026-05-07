import 'package:equatable/equatable.dart';
import 'package:property256/core/database/database_constants.dart';
import 'package:property256/core/util/sqlite_column_values.dart';

/// Row model for [ExpensesTable] (`expenses`).
final class ExpenseModel extends Equatable {
  const ExpenseModel({
    required this.id,
    required this.propertyId,
    required this.category,
    required this.amount,
    required this.spentAt,
    this.description,
  });

  final String id;
  final String propertyId;
  final String category;
  final int amount;
  final DateTime spentAt;
  final String? description;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      ExpensesTable.id: id,
      ExpensesTable.propertyId: propertyId,
      ExpensesTable.category: category,
      ExpensesTable.amount: amount,
      ExpensesTable.spentAt: sqliteDateTimeToColumn(spentAt),
      ExpensesTable.description: description,
    };
  }

  factory ExpenseModel.fromMap(final Map<String, Object?> map) {
    final String id = stringFromColumn(map[ExpensesTable.id]);
    if (id.isEmpty) {
      throw FormatException('Expense id must not be empty');
    }
    final String propertyId = stringFromColumn(map[ExpensesTable.propertyId]);
    if (propertyId.isEmpty) {
      throw FormatException('Expense propertyId must not be empty');
    }
    return ExpenseModel(
      id: id,
      propertyId: propertyId,
      category: stringFromColumn(map[ExpensesTable.category]),
      amount: intFromColumn(map[ExpensesTable.amount]),
      spentAt: sqliteDateTimeFromColumn(map[ExpensesTable.spentAt]),
      description: stringFromColumnNullable(map[ExpensesTable.description]),
    );
  }

  @override
  List<Object?> get props => <Object?>[
    id,
    propertyId,
    category,
    amount,
    spentAt,
    description,
  ];
}
