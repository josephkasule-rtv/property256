import 'package:flutter/material.dart';
import 'package:property256/core/models/property_entity.dart';
import 'package:property256/core/providers/property_provider.dart';
import 'package:property256/ui/util/currency_formatter.dart';
import 'package:provider/provider.dart';

class PropertyDetailArguments {
  const PropertyDetailArguments({required this.propertyId});

  final String propertyId;
}

class PropertyDetailScreen extends StatelessWidget {
  const PropertyDetailScreen({required this.propertyId, super.key});

  final String propertyId;

  @override
  Widget build(final BuildContext context) {
    final PropertyProvider provider = context.watch<PropertyProvider>();
    final PropertyEntity? property = provider.getPropertyById(id: propertyId);

    if (property == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Property details')),
        body: const Center(child: Text('Property not found.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(property.title)),
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
            if (property.isAvailable) ...<Widget>[
              const SizedBox(height: 20),
              Row(
                children: <Widget>[
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_upward),
                    label: const Text('Upvote'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Request Viewing'),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
