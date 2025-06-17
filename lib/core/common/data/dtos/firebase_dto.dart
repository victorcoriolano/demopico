class FirebaseDTO {
  final String id;
  final Map<String, dynamic> data;

  FirebaseDTO({required this.id, required this.data});

  FirebaseDTO copyWith({
    String? id,
    Map<String, dynamic>? data,
  }) {
    return FirebaseDTO(
      id: id ?? this.id,
      data: data ?? this.data,
    );
  }

}
