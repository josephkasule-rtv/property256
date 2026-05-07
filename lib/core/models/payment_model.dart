import 'package:equatable/equatable.dart';
import 'package:property256/core/database/database_constants.dart';
import 'package:property256/core/util/sqlite_column_values.dart';

/// Row model for [PaymentsTable] (`payments`).
final class PaymentModel extends Equatable {
  const PaymentModel({
    required this.id,
    required this.tenantId,
    required this.amount,
    required this.paidAt,
    required this.periodMonth,
    required this.method,
    this.reference,
  });

  final String id;
  final String tenantId;
  final int amount;
  final DateTime paidAt;

  /// Billing period, e.g. `2026-05`.
  final String periodMonth;
  final String method;
  final String? reference;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      PaymentsTable.id: id,
      PaymentsTable.tenantId: tenantId,
      PaymentsTable.amount: amount,
      PaymentsTable.paidAt: sqliteDateTimeToColumn(paidAt),
      PaymentsTable.periodMonth: periodMonth,
      PaymentsTable.method: method,
      PaymentsTable.reference: reference,
    };
  }

  factory PaymentModel.fromMap(final Map<String, Object?> map) {
    final String id = stringFromColumn(map[PaymentsTable.id]);
    if (id.isEmpty) {
      throw FormatException('Payment id must not be empty');
    }
    final String tenantId = stringFromColumn(map[PaymentsTable.tenantId]);
    if (tenantId.isEmpty) {
      throw FormatException('Payment tenantId must not be empty');
    }
    return PaymentModel(
      id: id,
      tenantId: tenantId,
      amount: intFromColumn(map[PaymentsTable.amount]),
      paidAt: sqliteDateTimeFromColumn(map[PaymentsTable.paidAt]),
      periodMonth: stringFromColumn(map[PaymentsTable.periodMonth]),
      method: stringFromColumn(map[PaymentsTable.method]),
      reference: stringFromColumnNullable(map[PaymentsTable.reference]),
    );
  }

  @override
  List<Object?> get props => <Object?>[
    id,
    tenantId,
    amount,
    paidAt,
    periodMonth,
    method,
    reference,
  ];
}
