import 'package:demopico/features/profile/domain/interfaces/i_message_repository.dart';
import 'package:demopico/features/profile/domain/models/chat.dart';
import 'package:flutter/material.dart';

enum StateViewModel { loading, success, error}

class ChatListViewModel extends ChangeNotifier {
  final ImessageRepository _repository;
  
  ChatListViewModel({
    required ImessageRepository repository,
  }): _repository = repository;

  List<Chat> chats = [];
  String? statement;
  StateViewModel stateVM = StateViewModel.loading;

  Future<void> fetchChats(String idUser) async {
    try {
      chats = await _repository.getChatForUser(idUser);
      stateVM =StateViewModel.success;
    } catch (e, st){
      debugPrint("VM - Erro na view model: ${e.toString()} $st");
      stateVM = StateViewModel.error;
      statement = "Ocorreu um erro ao carregar a tela";
    } finally {
      notifyListeners();
    }
  }
}