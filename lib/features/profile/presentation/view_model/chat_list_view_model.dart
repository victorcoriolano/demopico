import 'dart:async';

import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
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

  Future<void> fetchChats(UserIdentification userIdenti) async {
    stateVM = StateViewModel.loading;
    notifyListeners();
    try {
      chats = await _repository.getChatForUser(userIdenti);
      debugPrint("chats: ${chats.length}");
      stateVM = StateViewModel.success;
    } catch (e, st){
      debugPrint("VM - Erro na view model: ${e.toString()} $st");
      stateVM = StateViewModel.error;
      statement = "Ocorreu um erro ao carregar a tela";
    } finally {
      notifyListeners();
    }
  }

  Future<Conversation?> createChat(UserIdentification currentUser, UserIdentification otherUser) async {
    stateVM = StateViewModel.loading;
    notifyListeners();
    try {
      if (chats.isEmpty) await fetchChats(currentUser);
      if (chats.any((chat) => chat.participantsIds.contains(otherUser.id))) return chats.firstWhere((chat) => chat.participantsIds.contains(otherUser.id)) as Conversation;
      final chat = Conversation.initFromUsers(currentUser, otherUser);
      final createChat = await _repository.createChat(chat ,currentUser);
      chats.add(createChat);
      return createChat as Conversation;
    } catch (e, st){
      debugPrint("VM - Erro na view model: ${e.toString()} $st");
      stateVM = StateViewModel.error;
      statement = "Ocorreu um erro ao criar chat";
      return null;
    } finally {
      notifyListeners();
    }
  }

  Future<Chat?> createOrGetCollectiveChat({required 
    UserIdentification currentUser, required 
    List<UserIdentification> members,required String nameChat,required String photo}) async {
      debugPrint("chamou o método");
      try{
        if (chats.isEmpty) await fetchChats(currentUser);
      if (chats.any((chat) => chat.nameChat == nameChat)) return (chats.firstWhere((chat) => chat.nameChat == nameChat) as GroupChat);
      debugPrint('grupo não encontrado - criando um novo');
      final chat = GroupChat.initial(members, nameChat, photo);
      await _repository.createChat(chat, currentUser);
      chats.add(chat);
      return chat;

      } on Failure catch (e){
        FailureServer.showError(e);
        return null;
      }
  }
}