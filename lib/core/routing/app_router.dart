import 'package:flutter/material.dart';
import 'package:property256/core/routing/app_routes.dart';
import 'package:property256/ui/modules/property/screens/property_detail_screen.dart';
import 'package:property256/ui/modules/property/screens/property_list_screen.dart';

abstract final class AppRouter {
  static Route<dynamic> generateRoute(final RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.propertyList:
        return MaterialPageRoute<void>(
          builder: (final BuildContext context) => const PropertyListScreen(),
          settings: settings,
        );
      case AppRoutes.propertyDetail:
        final PropertyDetailArguments arguments =
            settings.arguments! as PropertyDetailArguments;
        return MaterialPageRoute<void>(
          builder: (final BuildContext context) =>
              PropertyDetailScreen(propertyId: arguments.propertyId),
          settings: settings,
        );
      default:
        return MaterialPageRoute<void>(
          builder: (final BuildContext context) => const _UnknownRouteScreen(),
          settings: settings,
        );
    }
  }
}

class _UnknownRouteScreen extends StatelessWidget {
  const _UnknownRouteScreen();

  @override
  Widget build(final BuildContext context) {
    return const Scaffold(body: Center(child: Text('Route not found')));
  }
}
