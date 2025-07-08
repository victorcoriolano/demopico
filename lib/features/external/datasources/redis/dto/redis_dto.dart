class RedisDto  {
  final Map<String, dynamic> data;

  RedisDto({required this.data});

  RedisDto copyWith({
    Map<String, dynamic>? data,
  }) {
    return RedisDto(
      data: data ?? this.data,
    );
  }

}
