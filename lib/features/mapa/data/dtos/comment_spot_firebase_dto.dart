class CommenSpotFirebaseDto {
  final String id;
  final Map<String, dynamic> data;

  CommenSpotFirebaseDto({required this.id, required this.data});

  CommenSpotFirebaseDto copyWith({
    String? id,
    Map<String, dynamic>? data,
  }) => CommenSpotFirebaseDto(id: id ?? this.id, data: data ?? this.data);
}