import 'package:flutter/material.dart';
import 'package:property256/ui/modules/property/widgets/unit_form.dart';

class CreateUnitSheet extends StatelessWidget {
  const CreateUnitSheet({
    required this.isSubmitting,
    required this.onSubmit,
    super.key,
  });

  final bool isSubmitting;
  final Future<void> Function(UnitFormData data) onSubmit;

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: UnitForm(isSubmitting: isSubmitting, onSubmit: onSubmit),
    );
  }
}
