import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/equipment_controller.dart';
import '../models/equipment.dart';
import '../services/equipment_service.dart';
import '../widgets/equipment_card.dart';
import 'equipment_detail_screen.dart';

class EquipmentListScreen extends StatelessWidget {
  final String equipmentType;
  final Equipment equipment;

  const EquipmentListScreen({
    super.key,
    required this.equipmentType,
    required this.equipment,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          equipmentType,
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
      body: Consumer<EquipmentController>(
        builder: (context, equipmentController, child) {
          final typeEquipments = equipmentController.equipments
              .where((e) => e.type == equipmentType)
              .toList();

          if (typeEquipments.isEmpty) {
            return const Center(
              child: Text('No equipment found for this type'),
            );
          }

          // If only one equipment, show multiple instances based on quantity
          final displayEquipments = <Equipment>[];
          for (var eq in typeEquipments) {
            for (int i = 0; i < eq.quantity; i++) {
              displayEquipments.add(
                eq.copyWith(
                  id: '${eq.id}_${i + 1}',
                  name: eq.quantity > 1 ? '${eq.name} ${i + 1}' : eq.name,
                ),
              );
            }
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Info
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _getEquipmentTypeIcon(equipmentType),
                        color: Colors.blue.shade600,
                        size: 32,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              equipmentType,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade800,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${displayEquipments.length} ${displayEquipments.length == 1 ? 'unit' : 'units'} available',
                              style: TextStyle(
                                color: Colors.blue.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Equipment Grid
                Expanded(
                  child: _ReorderableEquipmentGrid(
                    equipments: displayEquipments,
                    onReorder: (oldIndex, newIndex) {
                      // Handle reordering of equipment units
                      if (oldIndex < newIndex) {
                        newIndex -= 1;
                      }
                      final Equipment item = displayEquipments.removeAt(oldIndex);
                      displayEquipments.insert(newIndex, item);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  IconData _getEquipmentTypeIcon(String type) {
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
}

class _ReorderableEquipmentGrid extends StatefulWidget {
  final List<Equipment> equipments;
  final Function(int, int) onReorder;

  const _ReorderableEquipmentGrid({
    required this.equipments,
    required this.onReorder,
  });

  @override
  State<_ReorderableEquipmentGrid> createState() => _ReorderableEquipmentGridState();
}

class _ReorderableEquipmentGridState extends State<_ReorderableEquipmentGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.1, // Increased for reduced height
      ),
      itemCount: widget.equipments.length,
      itemBuilder: (context, index) {
        final equipment = widget.equipments[index];
        return _buildDraggableEquipmentCard(context, equipment, index);
      },
    );
  }

  Widget _buildDraggableEquipmentCard(BuildContext context, Equipment equipment, int index) {
    return LongPressDraggable<int>(
      data: index,
      feedback: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          width: 150,
          height: 135,
          child: Transform.scale(
            scale: 1.1,
            child: EquipmentCard(
              equipment: equipment,
              onTap: () {},
            ),
          ),
        ),
      ),
      childWhenDragging: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
        child: Center(
          child: Icon(
            Icons.drag_indicator,
            color: Colors.grey.shade400,
            size: 32,
          ),
        ),
      ),
      onDragStarted: () {
        // Visual feedback when drag starts
      },
      onDragEnd: (details) {
        // Clean up when drag ends
      },
      child: DragTarget<int>(
        onAccept: (draggedIndex) {
          if (draggedIndex != index) {
            widget.onReorder(draggedIndex, index);
          }
        },
        builder: (context, candidateData, rejectedData) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: candidateData.isNotEmpty
                  ? Border.all(
                      color: const Color(0xFF1E40AF),
                      width: 2,
                    )
                  : null,
            ),
            child: EquipmentCard(
              equipment: equipment,
              onTap: () async {
                // Load detailed equipment with point properties
                final equipmentService = EquipmentService();
                final detailedEquipment = await equipmentService.getEquipmentWithDetails(equipment.id);
                
                if (detailedEquipment != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EquipmentDetailScreen(
                        equipment: detailedEquipment.copyWith(
                          id: equipment.id, // Keep the unit-specific ID
                          name: equipment.name, // Keep the unit-specific name
                        ),
                      ),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EquipmentDetailScreen(
                        equipment: equipment,
                      ),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
