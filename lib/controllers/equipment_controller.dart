import 'package:flutter/foundation.dart';
import '../models/equipment.dart';
import '../services/equipment_service.dart';

class EquipmentController extends ChangeNotifier {
  final EquipmentService _equipmentService = EquipmentService();
  
  List<Equipment> _equipments = [];
  List<Equipment> _filteredEquipments = [];
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';

  List<Equipment> get equipments => _filteredEquipments;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get searchQuery => _searchQuery;

  Future<void> loadEquipments() async {
    _setLoading(true);
    _error = null;

    try {
      _equipments = await _equipmentService.getAllEquipments();
      _filteredEquipments = List.from(_equipments);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  void searchEquipments(String query) {
    _searchQuery = query;
    
    if (query.isEmpty) {
      _filteredEquipments = List.from(_equipments);
    } else {
      _filteredEquipments = _equipments.where((equipment) {
        return equipment.name.toLowerCase().contains(query.toLowerCase()) ||
               equipment.type.toLowerCase().contains(query.toLowerCase()) ||
               equipment.location.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    
    notifyListeners();
  }

  Future<void> toggleEquipmentControl(String equipmentId, String propertyId, String newValue) async {
    print('🔄 Toggle called: equipmentId=$equipmentId, propertyId=$propertyId, newValue=$newValue');
    
    try {
      await _equipmentService.updateEquipmentProperty(equipmentId, propertyId, newValue);
      print('✅ Service call completed');
      
      // Extract base equipment ID (remove unit suffix like _1, _2, etc.)
      String baseEquipmentId = equipmentId.split('_')[0];
      print('🔍 Base equipment ID: $baseEquipmentId');
      
      // Update local data - look for base equipment first
      int equipmentIndex = _equipments.indexWhere((e) => e.id == equipmentId);
      if (equipmentIndex == -1) {
        // If not found, try base equipment ID
        equipmentIndex = _equipments.indexWhere((e) => e.id == baseEquipmentId);
        print('� Using base equipment ID, index: $equipmentIndex');
      }
      print('�📍 Equipment index: $equipmentIndex');
      
      if (equipmentIndex != -1) {
        final equipment = _equipments[equipmentIndex];
        final propertyIndex = equipment.properties.indexWhere((p) => p.id == propertyId);
        print('📍 Property index: $propertyIndex');
        
        if (propertyIndex != -1) {
          final updatedProperties = List<EquipmentProperty>.from(equipment.properties);
          print('📝 Old value: ${updatedProperties[propertyIndex].value}');
          
          updatedProperties[propertyIndex] = updatedProperties[propertyIndex].copyWith(value: newValue);
          print('📝 New value set: ${updatedProperties[propertyIndex].value}');
          
          // Auto-sync status when command changes
          String? statusPropertyId;
          if (propertyId.contains('fan_on_off_command')) {
            statusPropertyId = 'fan_on_off_status';
          } else if (propertyId.contains('pump_on_off_command')) {
            statusPropertyId = 'pump_on_off_status';
          } else if (propertyId.contains('esp_on_off_command')) {
            statusPropertyId = 'esp_on_off_status';
          }
          
          print('🔗 Status property ID: $statusPropertyId');
          
          // Update corresponding status property if it exists
          if (statusPropertyId != null) {
            final statusIndex = updatedProperties.indexWhere((p) => p.id == statusPropertyId);
            print('📍 Status index: $statusIndex');
            
            if (statusIndex != -1) {
              print('📝 Old status: ${updatedProperties[statusIndex].value}');
              updatedProperties[statusIndex] = updatedProperties[statusIndex].copyWith(value: newValue);
              print('📝 New status set: ${updatedProperties[statusIndex].value}');
            }
          }
          
          _equipments[equipmentIndex] = equipment.copyWith(
            properties: updatedProperties,
            lastUpdated: DateTime.now(),
          );
          
          print('✅ Equipment updated in list');
          
          // Update filtered list
          searchEquipments(_searchQuery);
          print('✅ Filtered list updated');
          
          // Notify listeners to update UI
          notifyListeners();
          print('✅ Listeners notified - UI should update now');
        }
      } else {
        print('❌ Equipment not found in controller list');
      }
    } catch (e) {
      print('❌ Error in toggleEquipmentControl: $e');
      _error = e.toString();
      notifyListeners();
    }
  }

  void reorderEquipments(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    
    final Equipment item = _filteredEquipments.removeAt(oldIndex);
    _filteredEquipments.insert(newIndex, item);
    
    // Update the main list as well
    final mainIndex = _equipments.indexWhere((e) => e.id == item.id);
    if (mainIndex != -1) {
      _equipments.removeAt(mainIndex);
      _equipments.insert(newIndex, item);
    }
    
    notifyListeners();
  }

  Equipment? getEquipmentById(String id) {
    try {
      return _equipments.firstWhere((e) => e.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Equipment> getEquipmentsByType(String type) {
    return _equipments.where((e) => e.type == type).toList();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
