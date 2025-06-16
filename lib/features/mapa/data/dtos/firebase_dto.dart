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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'data': data,
    };
  }

  factory FirebaseDTO.fromJson(Map<String, dynamic> json) {
    return FirebaseDTO(
      id: json['id'],
      data: Map<String, dynamic>.from(json['data']),
    );
  }
}
