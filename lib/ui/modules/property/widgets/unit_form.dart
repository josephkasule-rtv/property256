import 'package:flutter/material.dart';

class UnitFormData {
  const UnitFormData({
    required this.name,
    required this.rentAmount,
    required this.isOccupied,
  });

  final String name;
  final int rentAmount;
  final bool isOccupied;
}

class UnitForm extends StatefulWidget {
  const UnitForm({
    required this.isSubmitting,
    required this.onSubmit,
    super.key,
  });

  final bool isSubmitting;
  final Future<void> Function(UnitFormData data) onSubmit;

  @override
  State<UnitForm> createState() => _UnitFormState();
}

class _UnitFormState extends State<UnitForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rentController = TextEditingController();
  bool _isOccupied = false;

  @override
  void dispose() {
    _nameController.dispose();
    _rentController.dispose();
    super.dispose();
  }

  String? _validateName(final String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Unit name/number is required';
    }
    return null;
  }

  String? _validateRent(final String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Rent amount is required';
    }

    final int? rent = int.tryParse(value.trim());
    if (rent == null || rent <= 0) {
      return 'Rent amount must be a positive number';
    }
    return null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final UnitFormData data = UnitFormData(
      name: _nameController.text.trim(),
      rentAmount: int.parse(_rentController.text.trim()),
      isOccupied: _isOccupied,
    );

    await widget.onSubmit(data);
  }

  @override
  Widget build(final BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Add Unit', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Unit name/number'),
            validator: _validateName,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _rentController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Rent amount'),
            validator: _validateRent,
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<bool>(
            initialValue: _isOccupied,
            decoration: const InputDecoration(labelText: 'Status'),
            items: const <DropdownMenuItem<bool>>[
              DropdownMenuItem<bool>(value: false, child: Text('Vacant')),
              DropdownMenuItem<bool>(value: true, child: Text('Occupied')),
            ],
            onChanged: (final bool? value) {
              if (value == null) {
                return;
              }
              setState(() {
                _isOccupied = value;
              });
            },
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: widget.isSubmitting ? null : _submit,
              child: widget.isSubmitting
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Save Unit'),
            ),
          ),
        ],
      ),
    );
  }
}
