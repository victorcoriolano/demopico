import 'package:demopico/features/profile/presentation/widgets/chat_room_widgets.dart/in_message.dart';
import 'package:demopico/features/profile/presentation/widgets/chat_room_widgets.dart/out_message.dart';
import 'package:flutter/material.dart';

class ChatRoomPage extends StatefulWidget {

  const ChatRoomPage({ super.key });

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           body: ListView(
            children: const [
              InMessage(message: 'Hello'),
              OutMessage(message: 'Hi there'),
              OutMessage(message: 'How it going?'),
              InMessage(message: 'Everything is OK'),
              OutMessage(message: 'Goodbye'),
              InMessage(message: 'See you soon')
            ],
          ),
       );
  }
}