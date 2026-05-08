import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:property256/core/models/property_entity.dart';
import 'package:property256/core/repository/property_repository.dart';
import 'package:property256/main.dart';

void main() {
  testWidgets('creates property and returns to list', (
    final WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1200, 2200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final InMemoryPropertyRepository repository = InMemoryPropertyRepository();

    await tester.pumpWidget(Property256App(repository: repository));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Property256 Kampala'), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Create Property'), findsOneWidget);

    final String createdTitle =
        'Widget Property ${DateTime.now().microsecondsSinceEpoch}';

    await tester.enterText(find.byType(TextFormField).at(0), createdTitle);
    await tester.enterText(find.byType(TextFormField).at(1), 'Kololo, Kampala');
    await tester.enterText(find.byType(TextFormField).at(2), 'Plot 3, Kololo');
    await tester.enterText(find.byType(TextFormField).at(3), '3500000');
    await tester.enterText(find.byType(TextFormField).at(4), '3');
    await tester.enterText(find.byType(TextFormField).at(5), '2');
    await tester.enterText(find.byType(TextFormField).at(6), '110');
    await tester.enterText(
      find.byType(TextFormField).at(7),
      'https://example.com/new-property.jpg',
    );

    final Finder savePropertyButton = find.text('Save Property');
    expect(savePropertyButton, findsOneWidget);
    await tester.tap(savePropertyButton);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Property256 Kampala'), findsOneWidget);
    expect(find.text(createdTitle), findsOneWidget);
  });
}

class InMemoryPropertyRepository implements PropertyRepository {
  InMemoryPropertyRepository()
    : _properties = <PropertyEntity>[
        PropertyEntity(
          id: 'kololo-001',
          userId: 'static-user-001',
          title: 'Modern 3-Bedroom Apartment',
          location: 'Kololo, Kampala',
          address: 'Wampewo Avenue, Kololo',
          pricePerMonth: 4200000,
          bedrooms: 3,
          bathrooms: 2,
          squareMeters: 138,
          imageUrl: 'https://example.com/seed-property.jpg',
          description: 'Seed property for widget tests',
          isAvailable: true,
          listedAt: DateTime(2026, 4, 10),
        ),
      ];

  final List<PropertyEntity> _properties;

  @override
  Future<void> createProperty({required final PropertyEntity property}) async {
    _properties.insert(0, property);
  }

  @override
  Future<PropertyEntity?> getPropertyById({required final String id}) async {
    for (final PropertyEntity property in _properties) {
      if (property.id == id) {
        return property;
      }
    }

    return null;
  }

  @override
  Future<List<PropertyEntity>> getProperties() async {
    return List<PropertyEntity>.unmodifiable(_properties);
  }
}
