import 'package:flutter/material.dart';
import 'package:property256/core/models/property_entity.dart';
import 'package:property256/core/models/unit_entity.dart';
import 'package:property256/core/providers/property_provider.dart';
import 'package:property256/ui/modules/property/widgets/create_unit_sheet.dart';
import 'package:property256/ui/modules/property/widgets/unit_form.dart';
import 'package:property256/ui/util/currency_formatter.dart';
import 'package:provider/provider.dart';

class PropertyDetailArguments {
  const PropertyDetailArguments({required this.propertyId});

  final String propertyId;
}

class PropertyDetailScreen extends StatefulWidget {
  const PropertyDetailScreen({required this.propertyId, super.key});

  final String propertyId;

  @override
  State<PropertyDetailScreen> createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((final Duration timeStamp) {
      if (!mounted) {
        return;
      }

      context.read<PropertyProvider>().loadUnitsForProperty(
        propertyId: widget.propertyId,
      );
    });
  }

  @override
  Widget build(final BuildContext context) {
    final PropertyProvider provider = context.watch<PropertyProvider>();
    final PropertyEntity? property = provider.getPropertyById(
      id: widget.propertyId,
    );

    if (property == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Property details')),
        body: const Center(child: Text('Property not found.')),
      );
    }

    final List<UnitEntity> units = provider.unitsForProperty(propertyId: property.id);
    final bool isLoadingUnits = provider.isLoadingUnitsForProperty(
      propertyId: property.id,
    );

    return Scaffold(
      appBar: AppBar(title: Text(property.title)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openCreateUnitSheet(context: context, property: property),
        icon: const Icon(Icons.add_business),
        label: const Text('Add Unit'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              child: Image.network(
                property.imageUrl,
                width: double.infinity,
                height: 230,
                fit: BoxFit.cover,
                errorBuilder:
                    (
                      final BuildContext context,
                      final Object error,
                      final StackTrace? stackTrace,
                    ) {
                      return Container(
                        width: double.infinity,
                        height: 230,
                        color: Colors.grey.shade300,
                        alignment: Alignment.center,
                        child: const Icon(Icons.home, size: 42),
                      );
                    },
              ),
            ),
            const SizedBox(height: 16),
            Text(
              property.location,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 6),
            Text(
              property.address,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            Text(
              CurrencyFormatter.ugxPerMonth(amount: property.pricePerMonth),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '${property.bedrooms} bedrooms • ${property.bathrooms} bathrooms • ${property.squareMeters.toStringAsFixed(0)} sqm',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Text(
              property.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Chip(
              label: Text(
                property.isAvailable ? 'Available now' : 'Not available',
              ),
              backgroundColor: property.isAvailable
                  ? Colors.green.shade100
                  : Colors.red.shade100,
            ),
            const SizedBox(height: 24),
            Text('Units', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            if (isLoadingUnits)
              const Center(child: CircularProgressIndicator())
            else if (units.isEmpty)
              const Text('No units yet. Tap "Add Unit" to create one.')
            else
              ...units.map((final UnitEntity unit) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    title: Text(unit.name),
                    subtitle: Text(
                      CurrencyFormatter.ugxPerMonth(amount: unit.rentAmount),
                    ),
                    trailing: Chip(
                      label: Text(unit.isOccupied ? 'Occupied' : 'Vacant'),
                      backgroundColor: unit.isOccupied
                          ? Colors.orange.shade100
                          : Colors.green.shade100,
                    ),
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }

  Future<void> _openCreateUnitSheet({
    required final BuildContext context,
    required final PropertyEntity property,
  }) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (final BuildContext context) {
        return Consumer<PropertyProvider>(
          builder:
              (
                final BuildContext sheetContext,
                final PropertyProvider provider,
                final Widget? child,
              ) {
                final bool isSubmitting = provider.isSubmittingUnitForProperty(
                  propertyId: property.id,
                );

                return CreateUnitSheet(
                  isSubmitting: isSubmitting,
                  onSubmit: (final UnitFormData data) async {
                    await _submitUnit(
                      screenContext: context,
                      sheetContext: sheetContext,
                      propertyId: property.id,
                      data: data,
                    );
                  },
                );
              },
        );
      },
    );
  }

  Future<void> _submitUnit({
    required final BuildContext screenContext,
    required final BuildContext sheetContext,
    required final String propertyId,
    required final UnitFormData data,
  }) async {
    final PropertyProvider provider = screenContext.read<PropertyProvider>();
    final UnitEntity unit = UnitEntity(
      id: 'unit-${DateTime.now().microsecondsSinceEpoch}',
      propertyId: propertyId,
      name: data.name,
      rentAmount: data.rentAmount,
      isOccupied: data.isOccupied,
      createdAt: DateTime.now(),
    );

    final bool created = await provider.createUnit(unit: unit);
    if (!screenContext.mounted || !sheetContext.mounted) {
      return;
    }

    if (created) {
      Navigator.of(sheetContext).pop();
      ScaffoldMessenger.of(screenContext).showSnackBar(
        const SnackBar(content: Text('Unit added successfully')),
      );
      return;
    }

    ScaffoldMessenger.of(screenContext).showSnackBar(
      const SnackBar(content: Text('Unable to create unit right now')),
    );
  }
}
