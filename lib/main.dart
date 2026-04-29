import 'package:flutter/material.dart';
import 'package:property256/core/routing/app_router.dart';
import 'package:property256/core/routing/app_routes.dart';
import 'package:property256/core/theme/app_theme.dart';
import 'package:property256/features/property/data/datasources/in_memory_property_datasource.dart';
import 'package:property256/features/property/data/repositories/property_repository_impl.dart';
import 'package:property256/features/property/domain/usecases/get_properties_usecase.dart';
import 'package:property256/features/property/presentation/providers/property_provider.dart';
import 'package:provider/provider.dart';

void main() {
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
