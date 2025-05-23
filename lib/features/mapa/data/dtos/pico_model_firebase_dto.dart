class PicoFirebaseDTO {
  final String id;
  final Map<String, dynamic> data;

  PicoFirebaseDTO({
    required this.id,
    required this.data,
  });

  PicoFirebaseDTO copyWith({
    String? id,
    Map<String, dynamic>? data,
  }) => PicoFirebaseDTO(id: id ?? this.id, data: data ?? this.data);
  
}