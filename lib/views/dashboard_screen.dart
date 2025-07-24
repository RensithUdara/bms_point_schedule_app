import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/equipment_controller.dart';
import '../models/equipment.dart';
import '../widgets/equipment_card.dart';
import '../widgets/app_drawer.dart';
import 'equipment_list_screen.dart';
import 'profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EquipmentController>().loadEquipments();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
    context.read<EquipmentController>().searchEquipments(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color(0xFF1E40AF),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.person_rounded, color: Colors.white, size: 20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search equipment...',
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 16,
                ),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: Colors.grey.shade500,
                  size: 24,
                ),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: Icon(
                          Icons.clear_rounded,
                          color: Colors.grey.shade500,
                        ),
                        onPressed: () {
                          _searchController.clear();
                          _onSearchChanged('');
                        },
                      )
                    : null,
                filled: true,
                fillColor: const Color(0xFFF8FAFC),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
            ),
          ),

          // Equipment Grid
          Expanded(
            child: Consumer<EquipmentController>(
              builder: (context, equipmentController, child) {
                if (equipmentController.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (equipmentController.error != null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Icons.error_outline_rounded,
                            size: 64,
                            color: Colors.red.shade400,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Error loading equipment',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          equipmentController.error!,
                          style: TextStyle(
                            color: Colors.red.shade600,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: () {
                            equipmentController.clearError();
                            equipmentController.loadEquipments();
                          },
                          icon: const Icon(Icons.refresh_rounded),
                          label: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                final equipments = equipmentController.equipments;

                if (equipments.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Icons.search_off_rounded,
                            size: 64,
                            color: Colors.grey.shade400,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          _searchQuery.isEmpty
                              ? 'No equipment found'
                              : 'No equipment matches your search',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        if (_searchQuery.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(
                            'Try adjusting your search terms',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: _ReorderableGridView(
                    equipments: equipments,
                    onReorder: (oldIndex, newIndex) {
                      equipmentController.reorderEquipments(oldIndex, newIndex);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ReorderableGridView extends StatefulWidget {
  final List<Equipment> equipments;
  final Function(int, int) onReorder;

  const _ReorderableGridView({
    required this.equipments,
    required this.onReorder,
  });

  @override
  State<_ReorderableGridView> createState() => _ReorderableGridViewState();
}

class _ReorderableGridViewState extends State<_ReorderableGridView> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2, // Increased for reduced height
      ),
      itemCount: widget.equipments.length,
      itemBuilder: (context, index) {
        final equipment = widget.equipments[index];
        return _buildDraggableCard(context, equipment, index);
      },
    );
  }

  Widget _buildDraggableCard(BuildContext context, Equipment equipment, int index) {
    return LongPressDraggable<int>(
      data: index,
      feedback: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          width: 150,
          height: 125,
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EquipmentListScreen(
                      equipmentType: equipment.type,
                      equipment: equipment,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
