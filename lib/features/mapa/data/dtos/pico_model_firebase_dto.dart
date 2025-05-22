class PicoModelFirebaseDto {
  final String id;
  final Map<String, dynamic> data;

  PicoModelFirebaseDto({
    required this.id,
    required this.data,
  });

  PicoModelFirebaseDto copyWith({
    String? id,
    Map<String, dynamic>? data,
  }) => PicoModelFirebaseDto(id: id ?? this.id, data: data ?? this.data);
  
}