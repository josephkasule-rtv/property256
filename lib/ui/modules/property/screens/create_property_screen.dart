import 'package:flutter/material.dart';
import 'package:property256/core/models/property_entity.dart';
import 'package:property256/core/providers/property_provider.dart';
import 'package:provider/provider.dart';

class CreatePropertyScreen extends StatefulWidget {
  const CreatePropertyScreen({super.key});

  @override
  State<CreatePropertyScreen> createState() => _CreatePropertyScreenState();
}

class _CreatePropertyScreenState extends State<CreatePropertyScreen> {
  static const String _staticUserId = 'static-user-001';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _bedroomsController = TextEditingController();
  final TextEditingController _bathroomsController = TextEditingController();
  final TextEditingController _squareMetersController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _addressController.dispose();
    _priceController.dispose();
    _bedroomsController.dispose();
    _bathroomsController.dispose();
    _squareMetersController.dispose();
    _imageUrlController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final PropertyProvider provider = context.read<PropertyProvider>();
    final PropertyEntity property = PropertyEntity(
      id: 'property-${DateTime.now().microsecondsSinceEpoch}',
      userId: _staticUserId,
      title: _titleController.text.trim(),
      location: _locationController.text.trim(),
      address: _addressController.text.trim(),
      pricePerMonth: int.parse(_priceController.text.trim()),
      bedrooms: int.parse(_bedroomsController.text.trim()),
      bathrooms: int.parse(_bathroomsController.text.trim()),
      squareMeters: double.parse(_squareMetersController.text.trim()),
      imageUrl: _imageUrlController.text.trim(),
      description: _descriptionController.text.trim(),
      isAvailable: true,
      listedAt: DateTime.now(),
    );

    final bool success = await provider.createProperty(property: property);
    if (!mounted) {
      return;
    }

    if (success) {
      Navigator.of(context).pop(true);
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          provider.submitErrorMessage ?? 'Unable to create property right now',
        ),
      ),
    );
  }

  String? _validateRequired(final String? value, final String fieldLabel) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldLabel is required';
    }
    return null;
  }

  String? _validateInt(final String? value, final String fieldLabel) {
    final String? requiredValidation = _validateRequired(value, fieldLabel);
    if (requiredValidation != null) {
      return requiredValidation;
    }

    final int? parsed = int.tryParse(value!.trim());
    if (parsed == null || parsed <= 0) {
      return '$fieldLabel must be a positive number';
    }

    return null;
  }

  String? _validateDouble(final String? value, final String fieldLabel) {
    final String? requiredValidation = _validateRequired(value, fieldLabel);
    if (requiredValidation != null) {
      return requiredValidation;
    }

    final double? parsed = double.tryParse(value!.trim());
    if (parsed == null || parsed <= 0) {
      return '$fieldLabel must be a positive number';
    }

    return null;
  }

  @override
  Widget build(final BuildContext context) {
    final PropertyProvider provider = context.watch<PropertyProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Create Property')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Name / Title'),
              validator: (final String? value) =>
                  _validateRequired(value, 'Name / Title'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _locationController,
              decoration: const InputDecoration(labelText: 'Location'),
              validator: (final String? value) =>
                  _validateRequired(value, 'Location'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Address'),
              validator: (final String? value) =>
                  _validateRequired(value, 'Address'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Price per month'),
              validator: (final String? value) =>
                  _validateInt(value, 'Price per month'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _bedroomsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Bedrooms'),
              validator: (final String? value) => _validateInt(value, 'Bedrooms'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _bathroomsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Bathrooms'),
              validator: (final String? value) =>
                  _validateInt(value, 'Bathrooms'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _squareMetersController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Square meters'),
              validator: (final String? value) =>
                  _validateDouble(value, 'Square meters'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _imageUrlController,
              decoration: const InputDecoration(labelText: 'Image URL'),
              validator: (final String? value) =>
                  _validateRequired(value, 'Image URL'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _descriptionController,
              minLines: 3,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Description (optional)',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: provider.isSubmitting ? null : _submit,
              child: provider.isSubmitting
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Save Property'),
            ),
          ],
        ),
      ),
    );
  }
}
