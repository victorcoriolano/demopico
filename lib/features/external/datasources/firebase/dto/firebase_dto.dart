class FirebaseDTO {
  String _id;
  final Map<String, dynamic> data;

  FirebaseDTO({required String id, required this.data}) : _id = id;

  FirebaseDTO copyWith({
    String? id,
    Map<String, dynamic>? data,
  }) {
    return FirebaseDTO(
      id: id ?? _id,
      data: data ?? this.data,
    );
  }

  String get id => _id;

  set setId(String newId) {
    _id = newId;
  }

}
