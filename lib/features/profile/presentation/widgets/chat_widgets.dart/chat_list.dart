import 'package:cached_network_image/cached_network_image.dart';
import 'package:demopico/core/app/routes/app_routes.dart';
import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/features/profile/domain/models/chat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatList extends StatelessWidget {
  final List<Chat> chats;
  final String currentID;
  const   ChatList({super.key, required this.chats, required this.currentID});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index];

        switch (chat) {
          case Conversation():
            {
              final conversa = chat;
              debugPrint('conversa: ${conversa.photoUrl}');
              debugPrint('conversa: ${conversa.nameChat}');
              debugPrint('conversa: ${conversa.participantsIds}');
              return ItemChat(chat: chat, isConversation: true);
            }
          case GroupChat():
            {
              return ItemChat(chat: chat, isConversation: false);
            }
        }
      },
    );
  }
}

class ItemChat extends StatelessWidget {
  final Chat chat;
  final bool isConversation;
  const ItemChat({super.key , required this.chat, required this.isConversation});

  @override
  Widget build(BuildContext context) {
    return Container(
                margin: EdgeInsets.only(top: 12, left: 12, right: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: kLightGrey
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: chat.photoUrl != null 
                      ? CachedNetworkImageProvider(
                        chat.photoUrl!,
                        errorListener: (error) => const Icon(Icons.person),
                      )
                      : null,
                  ),
                  title: Text(chat.nameChat, style: TextStyle(fontWeight: FontWeight.bold ),),
                  subtitle: Text(
                    chat.lastMessage, 
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
}
