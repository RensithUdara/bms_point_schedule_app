import '../models/equipment.dart';

class EquipmentService {
  // Main equipment list for dashboard (BMS Point Schedule South Beach Weligama)
  Future<List<Equipment>> getAllEquipments() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    return [
      // Complete equipment list from BMS Point Schedule spreadsheet
      Equipment(
        id: '1',
        name: 'ESP Filter',
        type: 'Kitchen Equipment',
        location: 'Kitchen exhaust lvl',
        description: 'Electrostatic Precipitator Filter',
        imageUrl: 'assets/images/esp_filter.png',
        isControllable: true,
        isOnline: true,
        lastUpdated: DateTime.now(),
        quantity: 1,
        notes: 'DI/DO/M/CA(field devices Need to be provide by contractor)',
        properties: [
          EquipmentProperty(
            id: 'esp_on_off_command',
            name: 'ESP On/Off Command',
            value: 'OFF',
            unit: '',
            type: 'control',
            isControllable: true,
            controlOptions: ['ON', 'OFF'],
          ),
          EquipmentProperty(
            id: 'esp_on_off_status',
            name: 'ESP On/Off status',
            value: 'OFF',
            unit: '',
            type: 'monitor',
            isControllable: false,
          ),
          EquipmentProperty(
            id: 'esp_trip_status',
            name: 'ESP trip status',
            value: 'Normal',
            unit: '',
            type: 'monitor',
            isControllable: false,
          ),
          EquipmentProperty(
            id: 'field_devices_total',
            name: 'Field Devices Total',
            value: 'DI:1, DO:1, AI:0, AO:0, Monitoring:1, Alarm:1, Control:1, Data points:1, Interface points:1, Free config:1, Power analyzer:1',
            unit: '',
            type: 'status',
            isControllable: false,
          ),
        ],
      ),
      Equipment(
        id: '2',
        name: 'Lobby pressurization fans',
        type: 'HVAC',
        location: 'Roof',
        description: 'Lobby pressurization fans',
        imageUrl: 'assets/images/lobby_fans.png',
        isControllable: true,
        isOnline: true,
        lastUpdated: DateTime.now(),
        quantity: 2,
        notes: 'DI/DO/M/CA(field devices Need to be provide by contractor). Command Need to manual override from fire Command Center(LPF contractor Scope)',
        properties: [
          EquipmentProperty(
            id: 'fan_on_off_command',
            name: 'Fan on/off Command',
            value: 'OFF',
            unit: '',
            type: 'control',
            isControllable: true,
            controlOptions: ['ON', 'OFF'],
          ),
          EquipmentProperty(
            id: 'fan_on_off_status',
            name: 'Fan on/Off status',
            value: 'OFF',
            unit: '',
            type: 'monitor',
            isControllable: false,
          ),
          EquipmentProperty(
            id: 'fan_auto_off_manual_status',
            name: 'Fan Auto-Off-Manual Status',
            value: 'Manual',
            unit: '',
            type: 'monitor',
            isControllable: false,
          ),
          EquipmentProperty(
            id: 'fan_fault_status',
            name: 'Fan fault Status',
            value: 'Normal',
            unit: '',
            type: 'monitor',
            isControllable: false,
          ),
          EquipmentProperty(
            id: 'field_devices_total',
            name: 'Field Devices Total',
            value: 'DI:1, DO:2, AI:0, AO:0, Monitoring:2, Alarm:2, Control:2, Data points:2, Interface points:2, Free config:2, Power analyzer:2',
            unit: '',
            type: 'status',
            isControllable: false,
          ),
        ],
      ),
      Equipment(
        id: '3',
        name: 'Gardening pump',
        type: 'Water Management',
        location: 'MEP base',
        description: 'Water transfer Pump',
        imageUrl: 'assets/images/garden_pump.png',
        isControllable: true,
        isOnline: true,
        lastUpdated: DateTime.now(),
        quantity: 4,
        notes: 'DI/DO/M/CA',
        properties: [
          EquipmentProperty(
            id: 'pump_on_off_command',
            name: 'Pump on/off Command',
            value: 'OFF',
            unit: '',
            type: 'control',
            isControllable: true,
            controlOptions: ['ON', 'OFF'],
          ),
          EquipmentProperty(
            id: 'pump_on_off_status',
            name: 'Pump on/off Status',
            value: 'OFF',
            unit: '',
            type: 'monitor',
            isControllable: false,
          ),
          EquipmentProperty(
            id: 'pump_auto_off_manual_status',
            name: 'Pump Auto-Off-Manual Status',
            value: 'Manual',
            unit: '',
            type: 'monitor',
            isControllable: false,
          ),
          EquipmentProperty(
            id: 'pump_fault_status',
            name: 'Pump fault Status',
            value: 'Normal',
            unit: '',
            type: 'monitor',
            isControllable: false,
          ),
          EquipmentProperty(
            id: 'field_devices_total',
            name: 'Field Devices Total',
            value: 'DI:1, DO:4, AI:0, AO:0, Monitoring:4, Alarm:4, Control:4, Data points:4, Interface points:4, Free config:4, Power analyzer:4',
            unit: '',
            type: 'status',
            isControllable: false,
          ),
        ],
      ),
      Equipment(
        id: '4',
        name: 'hydrant pump',
        type: 'Fire Safety',
        location: 'MEP base',
        description: 'Fire hydrant pump system',
        imageUrl: 'assets/images/hydrant_pump.png',
        isControllable: true,
        isOnline: true,
        lastUpdated: DateTime.now(),
        quantity: 3,
        notes: 'DI/M/A',
        properties: [
          EquipmentProperty(
            id: 'pump_on_off_status',
            name: 'Pump on/off Status',
            value: 'OFF',
            unit: '',
            type: 'monitor',
            isControllable: false,
          ),
          EquipmentProperty(
            id: 'pump_auto_off_manual_status',
            name: 'Pump Auto-Off-Manual Status',
            value: 'Auto',
            unit: '',
            type: 'monitor',
            isControllable: false,
          ),
          EquipmentProperty(
            id: 'pump_fault_status',
            name: 'Pump fault Status',
            value: 'Normal',
            unit: '',
            type: 'monitor',
            isControllable: false,
          ),
          EquipmentProperty(
            id: 'field_devices_total',
            name: 'Field Devices Total',
            value: 'DI:1, DO:0, AI:0, AO:0, Monitoring:3, Alarm:3, Control:0, Data points:3, Interface points:3, Free config:3, Power analyzer:3',
            unit: '',
            type: 'status',
            isControllable: false,
          ),
        ],
      ),
      Equipment(
        id: '5',
        name: 'Sprinkler Pump',
        type: 'Fire Safety',
        location: 'MEP base',
        description: 'Sprinkler system pump',
        imageUrl: 'assets/images/sprinkler_pump.png',
        isControllable: true,
        isOnline: true,
        lastUpdated: DateTime.now(),
        quantity: 3,
        notes: 'DI/M/A',
        properties: [
          EquipmentProperty(
            id: 'pump_on_off_status',
            name: 'Pump on/off Status',
            value: 'OFF',
            unit: '',
            type: 'monitor',
            isControllable: false,
          ),
          EquipmentProperty(
            id: 'pump_auto_off_manual_status',
            name: 'Pump Auto-Off-Manual Status',
            value: 'Auto',
            unit: '',
            type: 'monitor',
            isControllable: false,
          ),
          EquipmentProperty(
            id: 'pump_fault_status',
            name: 'Pump fault Status',
            value: 'Normal',
            unit: '',
            type: 'monitor',
            isControllable: false,
          ),
          EquipmentProperty(
            id: 'field_devices_total',
            name: 'Field Devices Total',
            value: 'DI:1, DO:0, AI:0, AO:0, Monitoring:3, Alarm:3, Control:0, Data points:3, Interface points:3, Free config:3, Power analyzer:3',
            unit: '',
            type: 'status',
            isControllable: false,
          ),
        ],
      ),
      Equipment(
        id: '6',
        name: 'Cutter Pump',
        type: 'Fire Safety',
        location: 'GF Land',
        description: 'Fire system cutter pump',
        imageUrl: 'assets/images/cutter_pump.png',
        isControllable: true,
        isOnline: true,
        lastUpdated: DateTime.now(),
        quantity: 2,
        notes: 'DI/DO/M/CA',
        properties: [
          EquipmentProperty(
            id: 'pump_on_off_command',
            name: 'Pump on/off Command',
            value: 'OFF',
            unit: '',
            type: 'control',
            isControllable: true,
            controlOptions: ['ON', 'OFF'],
          ),
          EquipmentProperty(
            id: 'pump_on_off_status',
            name: 'Pump on/off Status',
            value: 'OFF',
            unit: '',
            type: 'monitor',
            isControllable: false,
          ),
          EquipmentProperty(
            id: 'pump_auto_off_manual_status',
            name: 'Pump Auto-Off-Manual Status',
            value: 'Manual',
            unit: '',
            type: 'monitor',
            isControllable: false,
          ),
          EquipmentProperty(
            id: 'pump_fault_status',
            name: 'Pump fault Status',
            value: 'Normal',
            unit: '',
            type: 'monitor',
            isControllable: false,
          ),
          EquipmentProperty(
            id: 'field_devices_total',
            name: 'Field Devices Total',
            value: 'DI:1, DO:2, AI:0, AO:0, Monitoring:2, Alarm:2, Control:2, Data points:2, Interface points:2, Free config:2, Power analyzer:2',
            unit: '',
            type: 'status',
            isControllable: false,
          ),
        ],
      ),
      Equipment(
        id: '7',
        name: 'Sewer station',
        type: 'Water Management',
        location: 'GF land',
        description: 'Sewage pumping station',
        imageUrl: 'assets/images/sewer_station.png',
        isControllable: true,
        isOnline: true,
        lastUpdated: DateTime.now(),
        quantity: 1,
        notes: 'Both pumps shall be start and operate when water level reach maximum level and audible and visual alarm shall be provided for 24-hour manned station and Engineering office. Sewer pump station water levels. Sewer lifting station warning and high level alarm shall be indicated on the BMS.',
        properties: [
          EquipmentProperty(
            id: 'sewer_station_water_level_high',
            name: 'Sewer station Water Level High',
            value: 'Normal',
            unit: '',
            type: 'monitor',
            isControllable: false,
          ),
          EquipmentProperty(
            id: 'sewer_station_water_level_low',
            name: 'Sewer station Water Level Low',
            value: 'Normal',
            unit: '',
            type: 'monitor',
            isControllable: false,
          ),
          EquipmentProperty(
            id: 'field_devices_total',
            name: 'Field Devices Total',
            value: 'DI:0, DO:0, AI:1, AO:0, Monitoring:1, Alarm:1, Control:0, Data points:1, Interface points:1, Free config:1, Power analyzer:1',
            unit: '',
            type: 'status',
            isControllable: false,
          ),
        ],
      ),
      Equipment(
        id: '8',
        name: 'Booster Pump',
        type: 'Water Management',
        location: 'Roof top Pump room',
        description: 'Water pressure booster pump',
        imageUrl: 'assets/images/booster_pump.png',
        isControllable: true,
        isOnline: true,
        lastUpdated: DateTime.now(),
        quantity: 2,
        notes: 'DI/DO/M/CA',
        properties: [
          EquipmentProperty(
            id: 'pump_on_off_command',
            name: 'Pump on/off Command',
            value: 'OFF',
            unit: '',
            type: 'control',
            isControllable: true,
            controlOptions: ['ON', 'OFF'],
          ),
          EquipmentProperty(
            id: 'pump_on_off_status',
            name: 'Pump on/off Status',
            value: 'OFF',
            unit: '',
            type: 'monitor',
            isControllable: false,
          ),
          EquipmentProperty(
            id: 'pump_auto_off_manual_status',
            name: 'Pump Auto-Off-Manual Status',
            value: 'Auto',
            unit: '',
            type: 'monitor',
            isControllable: false,
          ),
          EquipmentProperty(
            id: 'pump_fault_status',
            name: 'Pump fault Status',
            value: 'Normal',
            unit: '',
            type: 'monitor',
            isControllable: false,
          ),
          EquipmentProperty(
            id: 'field_devices_total',
            name: 'Field Devices Total',
            value: 'DI:1, DO:2, AI:0, AO:0, Monitoring:2, Alarm:2, Control:4, Data points:2, Interface points:2, Free config:4, Power analyzer:4',
            unit: '',
            type: 'status',
            isControllable: false,
          ),
        ],
      ),
    ];
  }

  // Get detailed equipment with point properties based on spreadsheet
  Future<Equipment?> getEquipmentWithDetails(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    switch (id) {
      case '1': // ESP Filter
        return Equipment(
          id: '1',
          name: 'ESP Filter',
          type: 'Kitchen Equipment',
          location: 'Kitchen exhaust lvl',
          description: 'Electrostatic Precipitator Filter',
          imageUrl: 'assets/images/esp_filter.png',
          isControllable: true,
          isOnline: true,
          lastUpdated: DateTime.now(),
          quantity: 1,
          notes: 'DI/DO/M/CA(field devices Need to be provide by contractor)',
          properties: [
            EquipmentProperty(
              id: 'esp_on_off_command',
              name: 'ESP On/Off Command',
              value: 'OFF',
              unit: '',
              type: 'control',
              isControllable: true,
              controlOptions: ['ON', 'OFF'],
            ),
            EquipmentProperty(
              id: 'esp_on_off_status',
              name: 'ESP On/Off status',
              value: 'OFF',
              unit: '',
              type: 'monitor',
              isControllable: false,
            ),
            EquipmentProperty(
              id: 'esp_trip_status',
              name: 'ESP trip status',
              value: 'Normal',
              unit: '',
              type: 'monitor',
              isControllable: false,
            ),
          ],
        );
        
      case '2': // Lobby pressurization fans
        return Equipment(
          id: '2',
          name: 'Lobby pressurization fans',
          type: 'HVAC',
          location: 'Roof',
          description: 'Lobby pressurization fans',
          imageUrl: 'assets/images/lobby_fans.png',
          isControllable: true,
          isOnline: true,
          lastUpdated: DateTime.now(),
          quantity: 2,
          notes: 'DI/DO/M/CA(field devices Need to be provide by contractor). Command Need to manual override from fire Command Center(LPF contractor Scope)',
          properties: [
            EquipmentProperty(
              id: 'fan_on_off_command',
              name: 'Fan on/off Command',
              value: 'OFF',
              unit: '',
              type: 'control',
              isControllable: true,
              controlOptions: ['ON', 'OFF'],
            ),
            EquipmentProperty(
              id: 'fan_on_off_status',
              name: 'Fan on/Off status',
              value: 'OFF',
              unit: '',
              type: 'monitor',
              isControllable: false,
            ),
            EquipmentProperty(
              id: 'fan_auto_off_manual_status',
              name: 'Fan Auto-Off-Manual Status',
              value: 'Manual',
              unit: '',
              type: 'monitor',
              isControllable: false,
            ),
            EquipmentProperty(
              id: 'fan_fault_status',
              name: 'Fan fault Status',
              value: 'Normal',
              unit: '',
              type: 'monitor',
              isControllable: false,
            ),
          ],
        );

      case '3': // Gardening pump / Water transfer Pump
        return Equipment(
          id: '3',
          name: 'Gardening pump',
          type: 'Water Management',
          location: 'MEP base',
          description: 'Water transfer Pump',
          imageUrl: 'assets/images/garden_pump.png',
          isControllable: true,
          isOnline: true,
          lastUpdated: DateTime.now(),
          quantity: 4,
          notes: 'DI/DO/M/CA',
          properties: [
            EquipmentProperty(
              id: 'pump_on_off_command',
              name: 'Pump on/off Command',
              value: 'OFF',
              unit: '',
              type: 'control',
              isControllable: true,
              controlOptions: ['ON', 'OFF'],
            ),
            EquipmentProperty(
              id: 'pump_on_off_status',
              name: 'Pump on/off Status',
              value: 'OFF',
              unit: '',
              type: 'monitor',
              isControllable: false,
            ),
            EquipmentProperty(
              id: 'pump_auto_off_manual_status',
              name: 'Pump Auto-Off-Manual Status',
              value: 'Manual',
              unit: '',
              type: 'monitor',
              isControllable: false,
            ),
            EquipmentProperty(
              id: 'pump_fault_status',
              name: 'Pump fault Status',
              value: 'Normal',
              unit: '',
              type: 'monitor',
              isControllable: false,
            ),
          ],
        );

      case '4': // hydrant pump
        return Equipment(
          id: '4',
          name: 'hydrant pump',
          type: 'Fire Safety',
          location: 'MEP base',
          description: 'Fire hydrant pump system',
          imageUrl: 'assets/images/hydrant_pump.png',
          isControllable: true,
          isOnline: true,
          lastUpdated: DateTime.now(),
          quantity: 3,
          notes: 'DI/M/A',
          properties: [
            EquipmentProperty(
              id: 'pump_on_off_status',
              name: 'Pump on/off Status',
              value: 'OFF',
              unit: '',
              type: 'monitor',
              isControllable: false,
            ),
            EquipmentProperty(
              id: 'pump_auto_off_manual_status',
              name: 'Pump Auto-Off-Manual Status',
              value: 'Auto',
              unit: '',
              type: 'monitor',
              isControllable: false,
            ),
            EquipmentProperty(
              id: 'pump_fault_status',
              name: 'Pump fault Status',
              value: 'Normal',
              unit: '',
              type: 'monitor',
              isControllable: false,
            ),
          ],
        );

      case '5': // Sprinkler Pump
        return Equipment(
          id: '5',
          name: 'Sprinkler Pump',
          type: 'Fire Safety',
          location: 'MEP base',
          description: 'Sprinkler system pump',
          imageUrl: 'assets/images/sprinkler_pump.png',
          isControllable: true,
          isOnline: true,
          lastUpdated: DateTime.now(),
          quantity: 3,
          notes: 'DI/M/A',
          properties: [
            EquipmentProperty(
              id: 'pump_on_off_status',
              name: 'Pump on/off Status',
              value: 'OFF',
              unit: '',
              type: 'monitor',
              isControllable: false,
            ),
            EquipmentProperty(
              id: 'pump_auto_off_manual_status',
              name: 'Pump Auto-Off-Manual Status',
              value: 'Auto',
              unit: '',
              type: 'monitor',
              isControllable: false,
            ),
            EquipmentProperty(
              id: 'pump_fault_status',
              name: 'Pump fault Status',
              value: 'Normal',
              unit: '',
              type: 'monitor',
              isControllable: false,
            ),
          ],
        );

      case '6': // Cutter Pump
        return Equipment(
          id: '6',
          name: 'Cutter Pump',
          type: 'Fire Safety',
          location: 'GF Land',
          description: 'Fire system cutter pump',
          imageUrl: 'assets/images/cutter_pump.png',
          isControllable: true,
          isOnline: true,
          lastUpdated: DateTime.now(),
          quantity: 2,
          notes: 'DI/DO/M/CA',
          properties: [
            EquipmentProperty(
              id: 'pump_on_off_command',
              name: 'Pump on/off Command',
              value: 'OFF',
              unit: '',
              type: 'control',
              isControllable: true,
              controlOptions: ['ON', 'OFF'],
            ),
            EquipmentProperty(
              id: 'pump_on_off_status',
              name: 'Pump on/off Status',
              value: 'OFF',
              unit: '',
              type: 'monitor',
              isControllable: false,
            ),
            EquipmentProperty(
              id: 'pump_auto_off_manual_status',
              name: 'Pump Auto-Off-Manual Status',
              value: 'Manual',
              unit: '',
              type: 'monitor',
              isControllable: false,
            ),
            EquipmentProperty(
              id: 'pump_fault_status',
              name: 'Pump fault Status',
              value: 'Normal',
              unit: '',
              type: 'monitor',
              isControllable: false,
            ),
          ],
        );

      case '7': // Sewer station
        return Equipment(
          id: '7',
          name: 'Sewer station',
          type: 'Water Management',
          location: 'GF land',
          description: 'Sewage pumping station',
          imageUrl: 'assets/images/sewer_station.png',
          isControllable: true,
          isOnline: true,
          lastUpdated: DateTime.now(),
          quantity: 1,
          notes: 'Both pumps shall be start and operate when water level reach maximum level and audible and visual alarm shall be provided for 24-hour manned station and Engineering office. Sewer pump station water levels. Sewer lifting station warning and high level alarm shall be indicated on the BMS.',
          properties: [
            EquipmentProperty(
              id: 'sewer_station_water_level_high',
              name: 'Sewer station Water Level High',
              value: 'Normal',
              unit: '',
              type: 'monitor',
              isControllable: false,
            ),
            EquipmentProperty(
              id: 'sewer_station_water_level_low',
              name: 'Sewer station Water Level Low',
              value: 'Normal',
              unit: '',
              type: 'monitor',
              isControllable: false,
            ),
          ],
        );

      case '8': // Booster Pump
        return Equipment(
          id: '8',
          name: 'Booster Pump',
          type: 'Water Management',
          location: 'Roof top Pump room',
          description: 'Water pressure booster pump',
          imageUrl: 'assets/images/booster_pump.png',
          isControllable: true,
          isOnline: true,
          lastUpdated: DateTime.now(),
          quantity: 2,
          notes: 'DI/DO/M/CA',
          properties: [
            EquipmentProperty(
              id: 'pump_on_off_command',
              name: 'Pump on/off Command',
              value: 'OFF',
              unit: '',
              type: 'control',
              isControllable: true,
              controlOptions: ['ON', 'OFF'],
            ),
            EquipmentProperty(
              id: 'pump_on_off_status',
              name: 'Pump on/off Status',
              value: 'OFF',
              unit: '',
              type: 'monitor',
              isControllable: false,
            ),
            EquipmentProperty(
              id: 'pump_auto_off_manual_status',
              name: 'Pump Auto-Off-Manual Status',
              value: 'Auto',
              unit: '',
              type: 'monitor',
              isControllable: false,
            ),
            EquipmentProperty(
              id: 'pump_fault_status',
              name: 'Pump fault Status',
              value: 'Normal',
              unit: '',
              type: 'monitor',
              isControllable: false,
            ),
          ],
        );
        
      default:
        return null;
    }
  }

  Future<Equipment?> getEquipmentById(String id) async {
    final equipments = await getAllEquipments();
    try {
      return equipments.firstWhere((e) => e.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> updateEquipmentProperty(
      String equipmentId, String propertyId, String newValue) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // In a real app, this would make an API call to update the equipment property
    // For now, we'll just simulate success
  }

  // Method to update command and automatically sync status
  Future<void> updateEquipmentCommandAndStatus(
      String equipmentId, String propertyId, String newValue) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Auto-sync logic: when command changes, update corresponding status
    // This simulates the BMS system automatically reflecting command status
    
    // For example:
    // - fan_on_off_command → fan_on_off_status
    // - pump_on_off_command → pump_on_off_status
    // - esp_on_off_command → esp_on_off_status
    
    // In a real BMS system, this would happen automatically
    // when the field device responds to the command
  }

  Future<List<Equipment>> getEquipmentsByType(String type) async {
    final equipments = await getAllEquipments();
    return equipments.where((e) => e.type == type).toList();
  }
}
