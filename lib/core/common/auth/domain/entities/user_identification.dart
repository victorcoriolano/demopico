
class UserIdentification {
  final String id;
  final String name;
  final String photoUrl;

  UserIdentification({
    required this.id,
    required this.name,
    required this.photoUrl,
  });

  factory UserIdentification.fromJson(Map<String, dynamic> json) {
    return UserIdentification(id: json["idUser"], name: json["name"], photoUrl: json["photoUrl"]);
  }
  
  Map<String,dynamic> toJson() {
    return {
      "idUser": id,
      "name": name,
      "photoUrl": photoUrl,
    };
  }
}