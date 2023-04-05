import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/presentation/providers/chat_provider.dart';
import 'package:yes_no_app/presentation/widgets/chat/her_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              'https://z-p3-scontent.fkna1-1.fna.fbcdn.net/v/t1.18169-9/539390_338294789594986_1569132735_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=174925&_nc_eui2=AeGrUyLDeI9b0KqOuCXfh0Uq-qgd0YnhPof6qB3RieE-h9EbPfIKc_ObBQtkutJWWpM&_nc_ohc=H0IZ-SombH0AX9_n48o&_nc_ht=z-p3-scontent.fkna1-1.fna&oh=00_AfCePQQwSss1AUavdqq4ZZdor6qmhLALqQH-fuQKaX4X3A&oe=64544E8E',
            ),
          ),
        ),
        title: const Text('Clarita 🐈‍⬛'),
      ),
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // Hacer la referencia al Provider, para que esté pendiente de los cambios que sucedan en la instancia de la clase
    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                // referenciamos
                controller: chatProvider.chatScrollController,
                itemCount: chatProvider.messageList.length, // Saber cuantos mensajes hay
                itemBuilder: (context, index) {

                  final message = chatProvider.messageList[index];

                  return (message.fromWho == FromWho.hers)
                      ? HerMessageBubble(message: message)
                      : MyMessageBubble(message: message);

                  // return (index % 2 == 0)
                  //     ? const MyMessageBubble()
                  //     : const HerMessageBubble();
                },
              ),
            ),
            // Caja de texto
            MessageFieldBox(
              onValue: (value) => chatProvider.sendMessage(value),
            ),
          ],
        ),
      ),
    );
  }
}
