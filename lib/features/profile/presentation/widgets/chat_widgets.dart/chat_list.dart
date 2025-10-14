import 'package:cached_network_image/cached_network_image.dart';
import 'package:demopico/features/profile/domain/models/chat.dart';
import 'package:flutter/material.dart';

class ChatList extends StatelessWidget {
  final List<Chat> chats;
  final String currentID;
  const ChatList({ super.key, required this.chats, required this.currentID});

   @override
   Widget build(BuildContext context) {
       return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index];        

        switch(chat) {

          case Conversation() : {
            final otherParticipant = chat.participants.firstWhere(
          (user) => user.id != currentID,          
        );
            return ListTile(
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
              otherParticipant.photoUrl!, 
              errorListener: (error) => const Icon(Icons.person),
            ),
          ),
          title: Text(otherParticipant.name),
          subtitle: Text(
            chat.lastMessage.content,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Text(
            
            '${chat.lastMessage.dateTime.hour}:${chat.lastMessage.dateTime.minute.toString().padLeft(2, '0')}',
          ),
          onTap: () {
            // TODO: Navegar para a tela de detalhes do chat
            
          },
        );}
          case GroupChat()  : {
            return ListTile(
          leading: CircleAvatar(
            child: Icon(Icons.group),
          ),
          title: Text(chat.nameGroup),
          subtitle: Text(
            chat.lastMessage.content,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Text(
            
            '${chat.lastMessage.dateTime.hour}:${chat.lastMessage.dateTime.minute.toString().padLeft(2, '0')}',
          ),
          onTap: () {
            // TODO: Navegar para a tela de detalhes do chat
            
          },
        );}
        } 
       
      },
    );
  }
}