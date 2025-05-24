class SpotFirebaseDTO {
  final String id;
  final Map<String, dynamic> data;

  SpotFirebaseDTO({
    required this.id,
    required this.data,
  });

  SpotFirebaseDTO copyWith({
    String? id,
    Map<String, dynamic>? data,
  }) => SpotFirebaseDTO(id: id ?? this.id, data: data ?? this.data);
  
}