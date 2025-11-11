import 'package:demopico/core/app/routes/app_routes.dart';
import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/features/profile/domain/models/chat.dart';
import 'package:demopico/features/profile/presentation/view_model/chat_list_view_model.dart';
import 'package:demopico/features/user/presentation/controllers/auth_view_model_account.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class CreateChatFunctions {
  static Future<void> createConversation(
      BuildContext context, UserIdentification friend) async {
    Chat? chat;
    final currentUserIdentification =
        context.read<AuthViewModelAccount>().userIdentification;
    if (currentUserIdentification != null) {
      chat = await context
          .read<ChatListViewModel>()
          .createChat(currentUserIdentification, friend);
    }
    if (chat != null) {
      Get.offAndToNamed(Paths.chat, arguments: chat);
    } else {
      Get.snackbar(
        "Erro",
        "Ocorreu um erro ao acessar o chat tente novamente mais tarde",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
