import 'package:demopico/features/profile/domain/models/chat.dart';
import 'package:demopico/features/profile/presentation/view_model/chat_room_view_model.dart';
import 'package:demopico/features/profile/presentation/widgets/chat_widgets.dart/in_message.dart';
import 'package:demopico/features/profile/presentation/widgets/chat_widgets.dart/out_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ChatRoomPage extends StatefulWidget {
  final String idCurrentUser;
  const ChatRoomPage({super.key, required this.idCurrentUser});

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final chat = Get.arguments as Chat;
  final TextEditingController _editingController = TextEditingController();
  
  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nameChat = switch (chat){
      Conversation _ => (chat as Conversation).participants.firstWhere((u) => u.id != widget.idCurrentUser).name,
      GroupChat _ => (chat as GroupChat).nameGroup
    };
    final currentUserIdentification = chat.participants.firstWhere((u) => u.id == widget.idCurrentUser);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(nameChat),
      ),
      body: Stack(
        children: [
          StreamBuilder(
              stream: context.read<ChatRoomViewModel>().listenMessagesForChat(chat),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
          
                if (asyncSnapshot.hasError) {
                  return Center(
                    child: Text("Ocorreu um erro ao carregar a lista de mensagens"),
                  );
                }
          
                if (!asyncSnapshot.hasData || asyncSnapshot.data!.isEmpty) {
                  return Center(
                    child: Text("Nenhuma mensagem por aqui ainda"),
                  );
                }
                final messages = asyncSnapshot.data!;
          
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        bool isMyMessage =
                            messages[index].infoUser.id == widget.idCurrentUser;
                        return isMyMessage
                            ? OutMessage(message: messages[index].content)
                            : InMessage(message: messages[index].content);
                      }),
                );  
              }),
              Align(
            alignment: AlignmentGeometry.bottomCenter,
            child: Card(
              margin: EdgeInsets.all(12),
              child: Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _editingController,
                        readOnly: false,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        final provider = context.read<ChatRoomViewModel>();
                        if (_editingController.text.isNotEmpty){
                          final isSent = await provider.sendMessage(currentUserIdentification, _editingController.text, chat.id);
                          if(!isSent) Get.snackbar("Erro", "Não foi possivel enviar a mensagem");
                          Get.snackbar("Perfeito ✅", "Mensagem enviada com sucesso", duration: Duration(seconds: 1));
                          _editingController.clear();
                        }
                      }, 
                      icon: Icon(Icons.send))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      
          
    );
  }
}
