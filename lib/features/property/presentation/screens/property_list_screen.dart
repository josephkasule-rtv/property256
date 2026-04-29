import 'package:flutter/material.dart';
import 'package:property256/core/routing/app_routes.dart';
import 'package:property256/features/property/presentation/providers/property_provider.dart';
import 'package:property256/features/property/presentation/screens/property_detail_screen.dart';
import 'package:property256/features/property/presentation/widgets/property_card.dart';
import 'package:provider/provider.dart';

class PropertyListScreen extends StatefulWidget {
  const PropertyListScreen({super.key});

  @override
  State<PropertyListScreen> createState() => _PropertyListScreenState();
}

class _PropertyListScreenState extends State<PropertyListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((final Duration timeStamp) {
      final PropertyProvider provider = context.read<PropertyProvider>();
      if (provider.properties.isEmpty && !provider.isLoading) {
        provider.loadProperties();
      }
    });
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Property256 Kampala')),
      body: Consumer<PropertyProvider>(
        builder:
            (
              final BuildContext context,
              final PropertyProvider provider,
              final Widget? child,
            ) {
              if (provider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (provider.errorMessage != null) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      provider.errorMessage!,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }

              if (provider.properties.isEmpty) {
                return const Center(
                  child: Text('No properties available yet.'),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: provider.properties.length,
                separatorBuilder:
                    (final BuildContext context, final int index) {
                      return const SizedBox(height: 14);
                    },
                itemBuilder: (final BuildContext context, final int index) {
                  final property = provider.properties[index];

                  return PropertyCard(
                    property: property,
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        AppRoutes.propertyDetail,
                        arguments: PropertyDetailArguments(
                          propertyId: property.id,
                        ),
                      );
                    },
                  );
                },
              );
            },
      ),
    );
  }
}
