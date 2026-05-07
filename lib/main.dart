import 'package:flutter/material.dart';
import 'package:property256/core/database/app_database.dart';
import 'package:property256/core/routing/app_router.dart';
import 'package:property256/core/routing/app_routes.dart';
import 'package:property256/core/theme/app_theme.dart';
import 'package:property256/core/repository/in_memory_property_datasource.dart';
import 'package:property256/core/repository/property_repository_impl.dart';
import 'package:property256/core/services/get_properties_usecase.dart';
import 'package:property256/core/providers/property_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDatabase.instance.initialize();
  runApp(const Property256App());
}

class Property256App extends StatelessWidget {
  const Property256App({super.key});

  @override
  Widget build(final BuildContext context) {
    final InMemoryPropertyDataSource dataSource = InMemoryPropertyDataSource();
    final PropertyRepositoryImpl repository = PropertyRepositoryImpl(
      dataSource: dataSource,
    );

    return ChangeNotifierProvider<PropertyProvider>(
      create: (final BuildContext context) => PropertyProvider(
        getPropertiesUseCase: GetPropertiesUseCase(repository: repository),
      ),
      child: MaterialApp(
        title: 'Property256',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme(),
        initialRoute: AppRoutes.propertyList,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
