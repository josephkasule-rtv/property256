import 'package:flutter/foundation.dart';
import 'package:property256/features/property/domain/entities/property_entity.dart';
import 'package:property256/features/property/domain/usecases/get_properties_usecase.dart';

class PropertyProvider extends ChangeNotifier {
  PropertyProvider({required this.getPropertiesUseCase});

  final GetPropertiesUseCase getPropertiesUseCase;

  List<PropertyEntity> _properties = <PropertyEntity>[];
  bool _isLoading = false;
  String? _errorMessage;

  List<PropertyEntity> get properties => _properties;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadProperties() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _properties = await getPropertiesUseCase.call();
    } catch (_) {
      _errorMessage = 'Unable to load properties at the moment.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  PropertyEntity? getPropertyById({required final String id}) {
    for (final PropertyEntity property in _properties) {
      if (property.id == id) {
        return property;
      }
    }

    return null;
  }
}
