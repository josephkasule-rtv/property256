import 'package:flutter/material.dart';
import 'package:property256/core/models/property_entity.dart';
import 'package:property256/core/providers/property_provider.dart';
import 'package:property256/ui/modules/property/widgets/property_form.dart';
import 'package:provider/provider.dart';

class CreatePropertyScreen extends StatefulWidget {
  const CreatePropertyScreen({super.key});

  @override
  State<CreatePropertyScreen> createState() => _CreatePropertyScreenState();
}

class _CreatePropertyScreenState extends State<CreatePropertyScreen> {
  static const String _staticUserId = 'static-user-001';

  @override
  Widget build(final BuildContext context) {
    final PropertyProvider provider = context.watch<PropertyProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Create Property')),
      body: PropertyForm(
        isSubmitting: provider.isSubmitting,
        onSubmit: (final PropertyFormData data) async {
          final PropertyEntity property = PropertyEntity(
            id: 'property-${DateTime.now().microsecondsSinceEpoch}',
            userId: _staticUserId,
            title: data.title,
            location: data.location,
            address: data.address,
            pricePerMonth: data.pricePerMonth,
            bedrooms: data.bedrooms,
            bathrooms: data.bathrooms,
            squareMeters: data.squareMeters,
            imageUrl: data.imageUrl,
            description: data.description,
            isAvailable: true,
            listedAt: DateTime.now(),
          );

          final bool success = await provider.createProperty(property: property);
          if (!context.mounted) {
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
        },
      ),
    );
  }
}
