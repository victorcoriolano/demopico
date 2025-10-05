
class UserM {
  String id;
  String name;
  String email;
  DateTime dob;
  String? avatar;
  
  // Localização
  double? latitude;
  double? longitude;

  UserM({
    this.avatar,
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
    String? avatar,
  }) {
    return UserM(
      avatar: avatar ?? this.avatar,
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
      name: json['name'],
      email: json['email'],
      dob: DateTime.tryParse(json['dob']) ?? DateTime.now(),
      latitude: json['latitude'],
      longitude: json['longitude'],
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'dob': dob.toIso8601String(),
      'latitude': latitude,
      'longitude': longitude,
      'avatar': avatar,
    };
  }
}
