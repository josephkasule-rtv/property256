import 'package:flutter/foundation.dart';
import 'package:property256/core/models/property_entity.dart';
import 'package:property256/core/services/create_property_usecase.dart';
import 'package:property256/core/services/get_properties_usecase.dart';

class PropertyProvider extends ChangeNotifier {
  PropertyProvider({
    required this.getPropertiesUseCase,
    required this.createPropertyUseCase,
  });

  final GetPropertiesUseCase getPropertiesUseCase;
  final CreatePropertyUseCase createPropertyUseCase;

  List<PropertyEntity> _properties = <PropertyEntity>[];
  bool _isLoading = false;
  bool _isSubmitting = false;
  String? _errorMessage;
  String? _submitErrorMessage;

  List<PropertyEntity> get properties => _properties;
  bool get isLoading => _isLoading;
  bool get isSubmitting => _isSubmitting;
  String? get errorMessage => _errorMessage;
  String? get submitErrorMessage => _submitErrorMessage;

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

  Future<bool> createProperty({required final PropertyEntity property}) async {
    _isSubmitting = true;
    _submitErrorMessage = null;
    notifyListeners();

    try {
      await createPropertyUseCase.call(property: property);
      await loadProperties();
      return true;
    } catch (_) {
      _submitErrorMessage = 'Unable to save property right now.';
      return false;
    } finally {
      _isSubmitting = false;
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
