import 'package:cached_network_image/cached_network_image.dart';
import 'package:demopico/core/app/routes/app_routes.dart';
import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/features/profile/domain/models/chat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatList extends StatelessWidget {
  final List<Chat> chats;
  final String currentID;
  const ChatList({super.key, required this.chats, required this.currentID});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index];

        switch (chat) {
          case Conversation():
            {
              final otherParticipant = chat.participants.firstWhere(
                (user) => user.id != currentID,
              );
              return Container(
                margin: EdgeInsets.only(top: 12, left: 12, right: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: kLightGrey
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: otherParticipant.profilePictureUrl != null 
                      ? CachedNetworkImageProvider(
                        otherParticipant.profilePictureUrl!,
                        errorListener: (error) => const Icon(Icons.person),
                      )
                      : null,
                  ),
                  title: Text(otherParticipant.name, style: TextStyle(fontWeight: FontWeight.bold ),),
                  subtitle: Text(
                    chat.lastMessage != null
                        ? chat.lastMessage!
                        : "Inicie uma conversa com ${otherParticipant.name}",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 87, 82, 82)
                          ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: chat.lastUpdate != null
                      ? Text(
                          '${chat.lastUpdate!.hour}:${chat.lastUpdate!.minute.toString().padLeft(2, '0')}')
                      : null,
                  onTap: () {
                    Get.toNamed(Paths.chat, arguments: chat);
                  },
                ),
              );
            }
          case GroupChat():
            {
              return ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.group),
                ),
                title: Text(chat.nameGroup),
                subtitle: Text(
                  chat.lastMessage != null
                        ? chat.lastMessage!
                        : "Inicie a conversa no ${chat.nameGroup}",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 87, 82, 82)
                          ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                ),
                trailing: chat.lastUpdate != null
                      ? Text(
                          '${chat.lastUpdate!.hour}:${chat.lastUpdate!.minute.toString().padLeft(2, '0')}')
                      : null,
                onTap: () {
                  // TODO: Navegar para a tela de detalhes do chat
                },
              );
            }
        }
      },
    );
  }
}
