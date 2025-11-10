import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/features/profile/presentation/view_model/chat_list_view_model.dart';
import 'package:demopico/features/profile/presentation/widgets/chat_widgets/chat_list.dart';
import 'package:demopico/features/user/domain/enums/auth_state.dart';
import 'package:demopico/features/user/presentation/controllers/auth_view_model_account.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({
    super.key,
  });

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  String? idUser;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authState = context.read<AuthViewModelAccount>().authState;
      switch (authState) {
        case AuthAuthenticated():
          final user = UserIdentification(
              id: authState.user.id,
              name: authState.user.displayName.value,
              profilePictureUrl: authState.user.avatar);
          context.read<ChatListViewModel>().fetchChats(user);
          idUser = authState.user.id;
        case AuthUnauthenticated():
          context.read<ChatListViewModel>().statement =
              "Usuário não autenticado";
          context.read<ChatListViewModel>().stateVM = StateViewModel.error;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MINHAS CONVERSAS'),
        centerTitle: true,
      ),
      body: Consumer<ChatListViewModel>(builder: (context, viewModel, child) {
        // Usa um switch para construir a UI com base no estado da ViewModel
        switch (viewModel.stateVM) {
          case StateViewModel.loading:
            return const Center(child: CircularProgressIndicator());
          case StateViewModel.error:
            return Center(
              child: Text(viewModel.statement ?? 'Erro desconhecido'),
            );
          case StateViewModel.success:
            if (viewModel.chats.isEmpty) {
              return const Center(child: Text('Nenhuma conversa encontrada.'));
            }
            return ChatList(chats: viewModel.chats, currentID: idUser!);
        }
      }),
    );
  }
}
