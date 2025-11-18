

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

  @override
  bool operator ==(Object other){
    if (identical(this, other)) return true;
    return other is UserIdentification && other.id == id && other.name == name && other.profilePictureUrl == profilePictureUrl;
  }

  @override
  int get hashCode => Object.hash(id, profilePictureUrl, name);


  UserIdentification copyWith({
    String? id,
    String? name,
    String? profilePictureUrl,
  }){
    return UserIdentification(
      id: id ?? this.id,
      name: name ?? this.name,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
    );
  }
}