import 'package:flutter/material.dart';
import '../models/equipment.dart';

class EquipmentCard extends StatelessWidget {
  final Equipment equipment;
  final VoidCallback onTap;

  const EquipmentCard({
    super.key,
    required this.equipment,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Equipment icon
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        _getEquipmentColor(equipment.type).withOpacity(0.1),
                        _getEquipmentColor(equipment.type).withOpacity(0.05),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getEquipmentIcon(equipment.type),
                    size: 24,
                    color: _getEquipmentColor(equipment.type),
                  ),
                ),

                const SizedBox(height: 8),

                // Equipment name
                Expanded(
                  child: Text(
                    equipment.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1F2937),
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
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
        return const Color(0xFF06B6D4); // Cyan
      case 'hvac':
        return const Color(0xFF3B82F6); // Blue
      case 'fuel system':
        return const Color(0xFFF59E0B); // Amber
      case 'water management':
        return const Color(0xFF0EA5E9); // Sky blue
      case 'fire safety':
        return const Color(0xFFEF4444); // Red
      default:
        return const Color(0xFF6B7280); // Gray
    }
  }
}
