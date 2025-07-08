import 'dart:convert';

import 'package:demopico/features/external/datasources/redis/dto/redis_dto.dart';
import 'package:redis/redis.dart';

class Redis {
  final String channel;
  final String especialChannel;
  final String host;
  final int port;

  static Redis? _redis;
  static Redis get getInstance {
    _redis ??= Redis(channel: '', especialChannel: '');
    return _redis!;
  }

  Redis({
    required this.channel,
    required this.especialChannel,
    String? host,
    int? port,
  })  : host = host ?? 'localhost',
        port = port ?? 6379;

  Future<void> publish(RedisDto dto) async {
    final connection = RedisConnection();
    Command command = await connection.connect(host, port);
    await command.send_object(["PUBLISH", channel, dto]);
    await connection.close();
  }

  Future<void> publishToEspecial(RedisDto dto) async {
    final connection = RedisConnection();
    Command command = await connection.connect(host, port);
    final fullChannel = '$channel:$especialChannel';
    await command.send_object(["PUBLISH", fullChannel, dto]);
    await connection.close();
  }

   Future<void> subscribe(void Function(RedisDto) onMessage) async {
    final connection = RedisConnection();
    final command = await connection.connect(host, port);
    final pubSub = PubSub(command);

     pubSub.subscribe([channel]);

    pubSub.getStream().listen((message) {
      // message[0] = "message", message[1] = canal, message[2] = conteúdo
      final String payload = message[2];
      final Map<String, dynamic> data = jsonDecode(payload);
      final dto = RedisDto.fromJson(data);
      onMessage(dto);
    });
  }

  Future<void> subscribeToEspecial(void Function(RedisDto) onMessage) async {
    final connection = RedisConnection();
    final command = await connection.connect(host, port);
    final pubSub = PubSub(command);
    final fullChannel = '$channel:$especialChannel';

     pubSub.subscribe([fullChannel]);

    pubSub.getStream().listen((message) {
      final String payload = message[2];
      final Map<String, dynamic> data = jsonDecode(payload);
      final dto = RedisDto.fromJson(data);
      onMessage(dto);
    });
  }

  // Outros métodos como subscribe() podem ser adicionados aqui
}
