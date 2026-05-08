import 'package:flutter/foundation.dart';
import 'package:property256/core/models/property_entity.dart';
import 'package:property256/core/models/unit_entity.dart';
import 'package:property256/core/services/create_property_usecase.dart';
import 'package:property256/core/services/create_unit_usecase.dart';
import 'package:property256/core/services/get_properties_usecase.dart';
import 'package:property256/core/services/get_units_by_property_usecase.dart';

class PropertyProvider extends ChangeNotifier {
  PropertyProvider({
    required this.getPropertiesUseCase,
    required this.createPropertyUseCase,
    required this.getUnitsByPropertyUseCase,
    required this.createUnitUseCase,
  });

  final GetPropertiesUseCase getPropertiesUseCase;
  final CreatePropertyUseCase createPropertyUseCase;
  final GetUnitsByPropertyUseCase getUnitsByPropertyUseCase;
  final CreateUnitUseCase createUnitUseCase;

  List<PropertyEntity> _properties = <PropertyEntity>[];
  final Map<String, List<UnitEntity>> _unitsByPropertyId =
      <String, List<UnitEntity>>{};
  final Set<String> _loadingUnitsPropertyIds = <String>{};
  final Set<String> _submittingUnitPropertyIds = <String>{};
  bool _isLoading = false;
  bool _isSubmitting = false;
  String? _errorMessage;
  String? _submitErrorMessage;

  List<PropertyEntity> get properties => _properties;
  bool get isLoading => _isLoading;
  bool get isSubmitting => _isSubmitting;
  String? get errorMessage => _errorMessage;
  String? get submitErrorMessage => _submitErrorMessage;

  List<UnitEntity> unitsForProperty({required final String propertyId}) {
    return _unitsByPropertyId[propertyId] ?? <UnitEntity>[];
  }

  bool isLoadingUnitsForProperty({required final String propertyId}) {
    return _loadingUnitsPropertyIds.contains(propertyId);
  }

  bool isSubmittingUnitForProperty({required final String propertyId}) {
    return _submittingUnitPropertyIds.contains(propertyId);
  }

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

  Future<void> loadUnitsForProperty({required final String propertyId}) async {
    if (propertyId.isEmpty) {
      return;
    }

    _loadingUnitsPropertyIds.add(propertyId);
    notifyListeners();

    try {
      final List<UnitEntity> units = await getUnitsByPropertyUseCase.call(
        propertyId: propertyId,
      );
      _unitsByPropertyId[propertyId] = units;
    } finally {
      _loadingUnitsPropertyIds.remove(propertyId);
      notifyListeners();
    }
  }

  Future<bool> createUnit({required final UnitEntity unit}) async {
    final String propertyId = unit.propertyId;
    if (propertyId.isEmpty) {
      return false;
    }

    _submittingUnitPropertyIds.add(propertyId);
    notifyListeners();

    try {
      await createUnitUseCase.call(unit: unit);
      await loadUnitsForProperty(propertyId: propertyId);
      return true;
    } catch (_) {
      return false;
    } finally {
      _submittingUnitPropertyIds.remove(propertyId);
      notifyListeners();
    }
  }
}
