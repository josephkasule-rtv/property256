import 'package:flutter/material.dart';

class PropertyFormData {
  const PropertyFormData({
    required this.title,
    required this.location,
    required this.address,
    required this.pricePerMonth,
    required this.bedrooms,
    required this.bathrooms,
    required this.squareMeters,
    required this.imageUrl,
    required this.description,
  });

  final String title;
  final String location;
  final String address;
  final int pricePerMonth;
  final int bedrooms;
  final int bathrooms;
  final double squareMeters;
  final String imageUrl;
  final String description;
}

class PropertyForm extends StatefulWidget {
  const PropertyForm({
    required this.isSubmitting,
    required this.onSubmit,
    super.key,
  });

  final bool isSubmitting;
  final Future<void> Function(PropertyFormData data) onSubmit;

  @override
  State<PropertyForm> createState() => _PropertyFormState();
}

class _PropertyFormState extends State<PropertyForm> {
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

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final PropertyFormData data = PropertyFormData(
      title: _titleController.text.trim(),
      location: _locationController.text.trim(),
      address: _addressController.text.trim(),
      pricePerMonth: int.parse(_priceController.text.trim()),
      bedrooms: int.parse(_bedroomsController.text.trim()),
      bathrooms: int.parse(_bathroomsController.text.trim()),
      squareMeters: double.parse(_squareMetersController.text.trim()),
      imageUrl: _imageUrlController.text.trim(),
      description: _descriptionController.text.trim(),
    );

    await widget.onSubmit(data);
  }

  @override
  Widget build(final BuildContext context) {
    return Form(
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
            validator: (final String? value) => _validateRequired(value, 'Location'),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _addressController,
            decoration: const InputDecoration(labelText: 'Address'),
            validator: (final String? value) => _validateRequired(value, 'Address'),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _priceController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Price per month'),
            validator: (final String? value) => _validateInt(value, 'Price per month'),
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
            validator: (final String? value) => _validateInt(value, 'Bathrooms'),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _squareMetersController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(labelText: 'Square meters'),
            validator: (final String? value) => _validateDouble(value, 'Square meters'),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _imageUrlController,
            decoration: const InputDecoration(labelText: 'Image URL'),
            validator: (final String? value) => _validateRequired(value, 'Image URL'),
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
            onPressed: widget.isSubmitting ? null : _submit,
            child: widget.isSubmitting
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Save Property'),
          ),
        ],
      ),
    );
  }
}
