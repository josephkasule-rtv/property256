import 'package:flutter/material.dart';
import 'package:property256/features/property/domain/entities/property_entity.dart';
import 'package:property256/shared/utils/currency_formatter.dart';

class PropertyCard extends StatelessWidget {
  const PropertyCard({required this.property, required this.onTap, super.key});

  final PropertyEntity property;
  final VoidCallback onTap;

  @override
  Widget build(final BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(14)),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.network(
                  property.imageUrl,
                  height: 170,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (
                        final BuildContext context,
                        final Object error,
                        final StackTrace? stackTrace,
                      ) {
                        return Container(
                          height: 170,
                          alignment: Alignment.center,
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.home, size: 42),
                        );
                      },
                ),
              ),
              const SizedBox(height: 10),
              Text(
                property.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(
                property.location,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 4),
              Text(
                CurrencyFormatter.ugxPerMonth(amount: property.pricePerMonth),
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${property.bedrooms} beds • ${property.bathrooms} baths • ${property.squareMeters.toStringAsFixed(0)} sqm',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: Chip(
                  label: Text(property.isAvailable ? 'Available' : 'Taken'),
                  backgroundColor: property.isAvailable
                      ? Colors.green.shade100
                      : Colors.red.shade100,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
