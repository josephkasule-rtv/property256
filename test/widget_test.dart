import 'package:flutter_test/flutter_test.dart';
import 'package:property256/main.dart';

void main() {
  testWidgets('shows listing and opens detail screen', (
    final WidgetTester tester,
  ) async {
    await tester.pumpWidget(const Property256App());
    await tester.pumpAndSettle();

    expect(find.text('Property256 Kampala'), findsOneWidget);
    expect(find.text('Modern 3-Bedroom Apartment'), findsOneWidget);

    await tester.tap(find.text('Modern 3-Bedroom Apartment').first);
    await tester.pumpAndSettle();

    expect(find.text('Wampewo Avenue, Kololo'), findsOneWidget);
    expect(find.text('Available now'), findsOneWidget);
  });
}
