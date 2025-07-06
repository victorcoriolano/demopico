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

  Future<void> publish(String message) async {
    final connection = RedisConnection();
    Command command = await connection.connect(host, port);
    await command.send_object(["PUBLISH", channel, message]);
    await connection.close();
  }

  Future<void> publishToEspecial(String message) async {
    final connection = RedisConnection();
    Command command = await connection.connect(host, port);
    final fullChannel = '$channel:$especialChannel';
    await command.send_object(["PUBLISH", fullChannel, message]);
    await connection.close();
  }

  // Outros métodos como subscribe() podem ser adicionados aqui
}
