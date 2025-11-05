

class UserIdentification {
  final String id;
  final String name;
  final String? profilePictureUrl;

  UserIdentification({
    required this.id,
    required this.name,
    required this.profilePictureUrl,
  });

  factory UserIdentification.fromJson(Map<String, dynamic> json) {
    return UserIdentification(
      id: json["id"], 
      name: json["name"], 
      profilePictureUrl: json["profilePictureUrl"]);
  }
  
  Map<String,dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "profilePictureUrl": profilePictureUrl,
    };
  }

  @override
  String toString() {
    return 'UserIdentification(id: $id, name: $name, profilePictureUrl: $profilePictureUrl)';
  }
}