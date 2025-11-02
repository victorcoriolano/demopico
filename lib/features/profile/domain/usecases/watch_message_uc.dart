
import 'package:demopico/features/profile/domain/interfaces/i_message_repository.dart';
import 'package:demopico/features/profile/domain/models/chat.dart';
import 'package:demopico/features/profile/domain/models/message.dart';
import 'package:demopico/features/profile/infra/repository/chat_repository.dart';

class WatchMessageUc {
  final ImessageRepository _repository;

  WatchMessageUc(): _repository = ChatRepository.instance;

  Stream<List<Message>> execute(Chat chat){
    return _repository.watchMessagesForChat(chat.id);
  }
}