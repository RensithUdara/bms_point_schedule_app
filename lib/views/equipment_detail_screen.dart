import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/equipment_controller.dart';
import '../models/equipment.dart';

class EquipmentDetailScreen extends StatelessWidget {
  final Equipment equipment;

  const EquipmentDetailScreen({
    super.key,
    required this.equipment,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          equipment.name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color(0xFF1E40AF),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Equipment Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    _getEquipmentColor(equipment.type).withOpacity(0.1),
                    _getEquipmentColor(equipment.type).withOpacity(0.05),
                  ],
                ),
              ),
              child: Column(
                children: [
                  // Equipment Icon/Image
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: _getEquipmentColor(equipment.type).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Consumer<EquipmentController>(
                      builder: (context, controller, child) {
                        // Extract base equipment ID (remove unit suffix like _1, _2, etc.)
                        String baseEquipmentId = equipment.id.split('_')[0];
                        
                        // Get updated equipment for fan image
                        final updatedEquipment = controller.equipments.firstWhere(
                          (e) => e.id == baseEquipmentId,
                          orElse: () => equipment,
                        );
                        
                        return _buildEquipmentImageWithData(updatedEquipment);
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Equipment Name
                  Text(
                    equipment.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  
                  // Equipment Location
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          equipment.location,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Status Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildStatusChip(
                        equipment.isOnline ? 'Online' : 'Offline',
                        equipment.isOnline ? Colors.green : Colors.red,
                        equipment.isOnline ? Icons.wifi : Icons.wifi_off,
                      ),
                      const SizedBox(width: 12),
                      _buildStatusChip(
                        equipment.isControllable ? 'Controllable' : 'Monitor Only',
                        equipment.isControllable ? Colors.blue : Colors.orange,
                        equipment.isControllable ? Icons.settings : Icons.visibility,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Properties List
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Properties',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  for (var property in equipment.properties)
                    Consumer<EquipmentController>(
                      builder: (context, controller, child) {
                        // Extract base equipment ID (remove unit suffix like _1, _2, etc.)
                        String baseEquipmentId = equipment.id.split('_')[0];
                        
                        // Get updated equipment from controller
                        final updatedEquipment = controller.equipments.firstWhere(
                          (e) => e.id == baseEquipmentId,
                          orElse: () => equipment,
                        );
                        
                        // Get the updated property
                        final updatedProperty = updatedEquipment.properties.firstWhere(
                          (p) => p.id == property.id,
                          orElse: () => property,
                        );
                        
                        print('🔄 Consumer: baseId=$baseEquipmentId, property=${property.id}, value=${updatedProperty.value}');
                        
                        return _buildPropertyCard(context, updatedProperty);
                      },
                    ),

                  // Equipment Description
                  const SizedBox(height: 24),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.info_outline),
                              SizedBox(width: 8),
                              Text(
                                'Description',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            equipment.description,
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Field Devices Information
                  const SizedBox(height: 16),
                  _buildFieldDevicesCard(context),

                  // Equipment Notes
                  if (equipment.notes.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.notes, color: Colors.orange),
                                SizedBox(width: 8),
                                Text(
                                  'Notes',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              equipment.notes,
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],

                  // Last Updated
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.update,
                          size: 16,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Last updated: ${_formatDateTime(equipment.lastUpdated)}',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String label, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyCard(BuildContext context, EquipmentProperty property) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _getPropertyIcon(property.type),
                  size: 20,
                  color: _getPropertyColor(property.type),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    property.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getPropertyColor(property.type).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    property.type.toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: _getPropertyColor(property.type),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            if (property.isControllable && property.controlOptions != null) ...[
              // Control Toggle/Options
              Consumer<EquipmentController>(
                builder: (context, controller, child) {
                  // Check if this is an on/off control
                  bool isOnOffControl = property.controlOptions!.length == 2 &&
                      property.controlOptions!.any((option) => 
                          option.toLowerCase().contains('on') || 
                          option.toLowerCase().contains('off') ||
                          option.toLowerCase().contains('enable') || 
                          option.toLowerCase().contains('disable') ||
                          option.toLowerCase().contains('start') || 
                          option.toLowerCase().contains('stop'));

                  if (isOnOffControl) {
                    // Interactive Toggle Switch for on/off controls
                    String onOption = property.controlOptions!.firstWhere((option) =>
                        option.toLowerCase().contains('on') ||
                        option.toLowerCase().contains('enable') ||
                        option.toLowerCase().contains('start'));
                    String offOption = property.controlOptions!.firstWhere((option) =>
                        option.toLowerCase().contains('off') ||
                        option.toLowerCase().contains('disable') ||
                        option.toLowerCase().contains('stop'));
                    
                    bool isOn = property.value == onOption;
                    
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Current: ${property.value}${property.unit.isNotEmpty ? ' ${property.unit}' : ''}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            String newValue = isOn ? offOption : onOption;
                            print('🎯 Toggle button tapped!');
                            print('🎯 Current state: isOn=$isOn');
                            print('🎯 Current value: ${property.value}');
                            print('🎯 New value will be: $newValue');
                            print('🎯 Equipment ID: ${equipment.id}');
                            print('🎯 Property ID: ${property.id}');
                            
                            controller.toggleEquipmentControl(
                              equipment.id,
                              property.id,
                              newValue,
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 60,
                            height: 32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: isOn ? const Color(0xFF10B981) : Colors.grey.shade300,
                              boxShadow: [
                                BoxShadow(
                                  color: isOn 
                                      ? const Color(0xFF10B981).withOpacity(0.3)
                                      : Colors.grey.withOpacity(0.2),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: AnimatedAlign(
                              duration: const Duration(milliseconds: 200),
                              alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
                              child: Container(
                                width: 28,
                                height: 28,
                                margin: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    // Dropdown for other controls (with more than 2 options or non-on/off)
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButton<String>(
                        value: property.value,
                        isExpanded: true,
                        underline: const SizedBox(),
                        items: property.controlOptions!.map((option) {
                          return DropdownMenuItem(
                            value: option,
                            child: Text(
                              option,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          if (newValue != null) {
                            controller.toggleEquipmentControl(
                              equipment.id,
                              property.id,
                              newValue,
                            );
                          }
                        },
                      ),
                    );
                  }
                },
              ),
            ] else ...[
              // Read-only value
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        property.value,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (property.unit.isNotEmpty)
                      Text(
                        property.unit,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData _getEquipmentIcon(String type) {
    switch (type.toLowerCase()) {
      case 'air filtration':
        return Icons.air;
      case 'hvac':
        return Icons.ac_unit;
      case 'fuel system':
        return Icons.local_gas_station;
      case 'water management':
        return Icons.water_drop;
      case 'fire safety':
        return Icons.local_fire_department;
      default:
        return Icons.settings;
    }
  }

  Color _getEquipmentColor(String type) {
    switch (type.toLowerCase()) {
      case 'air filtration':
        return Colors.cyan;
      case 'hvac':
        return Colors.blue;
      case 'fuel system':
        return Colors.orange;
      case 'water management':
        return Colors.lightBlue;
      case 'fire safety':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getPropertyIcon(String type) {
    switch (type.toLowerCase()) {
      case 'control':
        return Icons.tune;
      case 'status':
        return Icons.info_outline;
      case 'monitor':
        return Icons.visibility;
      default:
        return Icons.settings;
    }
  }

  Color _getPropertyColor(String type) {
    switch (type.toLowerCase()) {
      case 'control':
        return Colors.blue;
      case 'status':
        return Colors.green;
      case 'monitor':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  Widget _buildFieldDevicesCard(BuildContext context) {
    // Find the field devices total property
    final fieldDevicesProperty = equipment.properties.firstWhere(
      (prop) => prop.id == 'field_devices_total',
      orElse: () => EquipmentProperty(
        id: 'empty',
        name: 'No Field Devices Info',
        value: '',
        unit: '',
        type: 'status',
        isControllable: false,
      ),
    );

    if (fieldDevicesProperty.id == 'empty') {
      return const SizedBox.shrink();
    }

    // Parse the field devices string
    final deviceInfo = fieldDevicesProperty.value.split(', ');
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.memory, color: Colors.purple),
                SizedBox(width: 8),
                Text(
                  'Field Devices',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: deviceInfo.map((device) {
                final parts = device.split(':');
                if (parts.length == 2) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.purple.withOpacity(0.3)),
                    ),
                    child: Text(
                      '${parts[0]}: ${parts[1]}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.purple.shade700,
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEquipmentImageWithData(Equipment updatedEquipment) {
    // Check if this is a fan equipment and get the control status
    if (updatedEquipment.name.toLowerCase().contains('fan') || 
        updatedEquipment.name.toLowerCase().contains('pressurization')) {
      
      // Find the fan control property
      final fanControlProperty = updatedEquipment.properties.firstWhere(
        (prop) => prop.id.contains('fan_on_off_command') || 
                  prop.id.contains('fan_control') ||
                  prop.name.toLowerCase().contains('fan') && prop.isControllable,
        orElse: () => EquipmentProperty(
          id: 'empty',
          name: 'No Control',
          value: 'OFF',
          unit: '',
          type: 'control',
          isControllable: false,
        ),
      );

      final isOn = fanControlProperty.value.toUpperCase() == 'ON';
      
      print('🖼️ Fan image: equipment=${updatedEquipment.name}, isOn=$isOn, controlValue=${fanControlProperty.value}');
      
      // Return different images based on fan status
      if (isOn) {
        // Show fan.gif when ON
        return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/images/fan.gif',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // Fallback to animated icon if GIF fails to load
                return Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.green, width: 2),
                  ),
                  child: const Icon(
                    Icons.air,
                    size: 50,
                    color: Colors.green,
                  ),
                );
              },
            ),
          ),
        );
      } else {
        // Show 1.png when OFF
        return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/images/1.png',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // Fallback to static icon if PNG fails to load
                return Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey, width: 2),
                  ),
                  child: Icon(
                    Icons.air,
                    size: 50,
                    color: Colors.grey.shade600,
                  ),
                );
              },
            ),
          ),
        );
      }
    }

    // For non-fan equipment, show regular icon
    return Icon(
      _getEquipmentIcon(updatedEquipment.type),
      size: 50,
      color: _getEquipmentColor(updatedEquipment.type),
    );
  }

  Widget _buildEquipmentImageWithUpdatedData(Equipment updatedEquipment) {
    // Check if this is a fan equipment and get the control status
    if (updatedEquipment.name.toLowerCase().contains('fan') || 
        updatedEquipment.name.toLowerCase().contains('pressurization')) {
      
      // Find the fan control property
      final fanControlProperty = updatedEquipment.properties.firstWhere(
        (prop) => prop.id.contains('fan_on_off_command') || 
                  prop.id.contains('fan_control') ||
                  prop.name.toLowerCase().contains('fan') && prop.isControllable,
        orElse: () => EquipmentProperty(
          id: 'empty',
          name: 'No Control',
          value: 'OFF',
          unit: '',
          type: 'control',
          isControllable: false,
        ),
      );

      final isOn = fanControlProperty.value.toUpperCase() == 'ON';
      
      // Return different images based on fan status
      if (isOn) {
        // Show fan.gif when ON
        return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/images/fan.gif',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // Fallback to animated icon if GIF fails to load
                return Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.green, width: 2),
                  ),
                  child: const Icon(
                    Icons.air,
                    size: 50,
                    color: Colors.green,
                  ),
                );
              },
            ),
          ),
        );
      } else {
        // Show 1.png when OFF
        return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/images/1.png',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // Fallback to static icon if PNG fails to load
                return Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey, width: 2),
                  ),
                  child: Icon(
                    Icons.air,
                    size: 50,
                    color: Colors.grey.shade600,
                  ),
                );
              },
            ),
          ),
        );
      }
    }

    // For non-fan equipment, show regular icon
    return Icon(
      _getEquipmentIcon(updatedEquipment.type),
      size: 50,
      color: _getEquipmentColor(updatedEquipment.type),
    );
  }

  Widget _buildEquipmentImage() {
    // Check if this is a fan equipment and get the control status
    if (equipment.name.toLowerCase().contains('fan') || 
        equipment.name.toLowerCase().contains('pressurization')) {
      
      // Find the fan control property
      final fanControlProperty = equipment.properties.firstWhere(
        (prop) => prop.id.contains('fan_on_off_command') || 
                  prop.id.contains('fan_control') ||
                  prop.name.toLowerCase().contains('fan') && prop.isControllable,
        orElse: () => EquipmentProperty(
          id: 'empty',
          name: 'No Control',
          value: 'OFF',
          unit: '',
          type: 'control',
          isControllable: false,
        ),
      );

      final isOn = fanControlProperty.value.toUpperCase() == 'ON';
      
      // Return different images based on fan status
      if (isOn) {
        // Show fan.gif when ON
        return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/images/fan.gif',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // Fallback to animated icon if GIF fails to load
                return Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.green, width: 2),
                  ),
                  child: const Icon(
                    Icons.air,
                    size: 50,
                    color: Colors.green,
                  ),
                );
              },
            ),
          ),
        );
      } else {
        // Show 1.png when OFF
        return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/images/1.png',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // Fallback to static icon if PNG fails to load
                return Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey, width: 2),
                  ),
                  child: Icon(
                    Icons.air,
                    size: 50,
                    color: Colors.grey.shade600,
                  ),
                );
              },
            ),
          ),
        );
      }
    }

    // For non-fan equipment, show regular icon
    return Icon(
      _getEquipmentIcon(equipment.type),
      size: 50,
      color: _getEquipmentColor(equipment.type),
    );
  }
}
