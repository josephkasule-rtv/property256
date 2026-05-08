import 'package:flutter/material.dart';
import 'package:property256/core/database/app_database.dart';
import 'package:property256/core/providers/property_provider.dart';
import 'package:property256/core/repository/property_repository.dart';
import 'package:property256/core/repository/property_repository_impl.dart';
import 'package:property256/core/routing/app_router.dart';
import 'package:property256/core/routing/app_routes.dart';
import 'package:property256/core/services/create_property_usecase.dart';
import 'package:property256/core/services/create_unit_usecase.dart';
import 'package:property256/core/services/get_properties_usecase.dart';
import 'package:property256/core/services/get_units_by_property_usecase.dart';
import 'package:property256/core/theme/app_theme.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDatabase.instance.initialize();
  runApp(const Property256App());
}

class Property256App extends StatelessWidget {
  const Property256App({super.key, final PropertyRepository? repository})
    : _repository = repository;

  final PropertyRepository? _repository;

  @override
  Widget build(final BuildContext context) {
    final PropertyRepository repository =
        _repository ?? const PropertyRepositoryImpl();

    return ChangeNotifierProvider<PropertyProvider>(
      create: (final BuildContext context) => PropertyProvider(
        getPropertiesUseCase: GetPropertiesUseCase(repository: repository),
        createPropertyUseCase: CreatePropertyUseCase(repository: repository),
        getUnitsByPropertyUseCase: GetUnitsByPropertyUseCase(
          repository: repository,
        ),
        createUnitUseCase: CreateUnitUseCase(repository: repository),
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
