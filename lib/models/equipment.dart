class Equipment {
  final String id;
  final String name;
  final String type;
  final String location;
  final String description;
  final String imageUrl;
  final List<EquipmentProperty> properties;
  final bool isControllable;
  final bool isOnline;
  final DateTime lastUpdated;
  final int quantity;
  final String notes;

  Equipment({
    required this.id,
    required this.name,
    required this.type,
    required this.location,
    required this.description,
    required this.imageUrl,
    required this.properties,
    required this.isControllable,
    required this.isOnline,
    required this.lastUpdated,
    this.quantity = 1,
    this.notes = '',
  });

  factory Equipment.fromJson(Map<String, dynamic> json) {
    return Equipment(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      location: json['location'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      properties: (json['properties'] as List)
          .map((p) => EquipmentProperty.fromJson(p))
          .toList(),
      isControllable: json['isControllable'],
      isOnline: json['isOnline'],
      lastUpdated: DateTime.parse(json['lastUpdated']),
      quantity: json['quantity'] ?? 1,
      notes: json['notes'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'location': location,
      'description': description,
      'imageUrl': imageUrl,
      'properties': properties.map((p) => p.toJson()).toList(),
      'isControllable': isControllable,
      'isOnline': isOnline,
      'lastUpdated': lastUpdated.toIso8601String(),
      'quantity': quantity,
      'notes': notes,
    };
  }

  Equipment copyWith({
    String? id,
    String? name,
    String? type,
    String? location,
    String? description,
    String? imageUrl,
    List<EquipmentProperty>? properties,
    bool? isControllable,
    bool? isOnline,
    DateTime? lastUpdated,
    int? quantity,
    String? notes,
  }) {
    return Equipment(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      location: location ?? this.location,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      properties: properties ?? this.properties,
      isControllable: isControllable ?? this.isControllable,
      isOnline: isOnline ?? this.isOnline,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      quantity: quantity ?? this.quantity,
      notes: notes ?? this.notes,
    );
  }
}

class EquipmentProperty {
  final String id;
  final String name;
  final String value;
  final String unit;
  final String type; // 'status', 'control', 'monitor'
  final bool isControllable;
  final List<String>? controlOptions;

  EquipmentProperty({
    required this.id,
    required this.name,
    required this.value,
    required this.unit,
    required this.type,
    required this.isControllable,
    this.controlOptions,
  });

  factory EquipmentProperty.fromJson(Map<String, dynamic> json) {
    return EquipmentProperty(
      id: json['id'],
      name: json['name'],
      value: json['value'],
      unit: json['unit'],
      type: json['type'],
      isControllable: json['isControllable'],
      controlOptions: json['controlOptions']?.cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'value': value,
      'unit': unit,
      'type': type,
      'isControllable': isControllable,
      'controlOptions': controlOptions,
    };
  }

  EquipmentProperty copyWith({
    String? id,
    String? name,
    String? value,
    String? unit,
    String? type,
    bool? isControllable,
    List<String>? controlOptions,
  }) {
    return EquipmentProperty(
      id: id ?? this.id,
      name: name ?? this.name,
      value: value ?? this.value,
      unit: unit ?? this.unit,
      type: type ?? this.type,
      isControllable: isControllable ?? this.isControllable,
      controlOptions: controlOptions ?? this.controlOptions,
    );
  }
}
