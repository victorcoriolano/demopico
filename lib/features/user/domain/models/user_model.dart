
class UserM {
  String id;
  String name;
  String email;
  DateTime dob;
  
  // Localização
  double? latitude;
  double? longitude;

  UserM({
    required this.id,
    required this.name,
    required this.email,
    required this.dob,
    this.latitude,
    this.longitude,
    
  });

  // CopyWith
  UserM copyWith({
    String? id,
    String? name,
    String? email,
    DateTime? dob,
    double? latitude,
    double? longitude,
  }) {
    return UserM(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      dob: dob ?? this.dob,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  // Serialização
  factory UserM.fromJson(Map<String, dynamic> json, String id) {
    return UserM(
      id: id,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      dob: DateTime.parse(json['dob'] ?? DateTime.now().toIso8601String()),
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'dob': dob.toIso8601String(),
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
