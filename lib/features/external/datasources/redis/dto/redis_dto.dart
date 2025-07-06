class RedisDto  {
  final String id;
  final Map<String, dynamic> data;

  RedisDto({required this.id, required this.data});

  RedisDto copyWith({
    String? id,
    Map<String, dynamic>? data,
  }) {
    return RedisDto(
      id: id ?? this.id,
      data: data ?? this.data,
    );
  }

}
