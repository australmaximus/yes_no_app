import 'package:flutter/material.dart';
import 'package:yes_no_app/config/helpers/get_yes_no_answer.dart';
import 'package:yes_no_app/domain/entities/message.dart';

// Provider permite tener los ChangeNotifier de manera global o en cierto contexto de la aplicación
// ChangeNotifier puede notificar cuando hay cambios en el estado de la aplicación para redibujar ciertas cosas
class ChatProvider extends ChangeNotifier {
  final ScrollController chatScrollController = ScrollController();
  
  final GetYesNoAnswer getYesNoAnswer = GetYesNoAnswer();

  List<Message> messageList = [];

  // Escribo mensaje y lo recibo en este método
  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;

    // Creo un nuevo mensaje, siempre va a ser mío
    final newMessage = Message(text: text, fromWho: FromWho.me);

    // Agrego el nuevo mensaje a la lista de mensajes
    messageList.add(newMessage);


    if(text.endsWith('?')) {
      herReplay();
    }

    // Notifico a los listeners que hay un cambio en el estado de la aplicación
    notifyListeners();

    moveScrollToBottom();
  }

  Future<void> herReplay() async {
    final herMessage = await getYesNoAnswer.getAnswer();

    messageList.add(herMessage);

    notifyListeners();

    moveScrollToBottom();
  }



  void moveScrollToBottom() async {

    await Future.delayed(const Duration(milliseconds: 100));

    chatScrollController.animateTo(
      // offset, posición en la que quiero que se mueva el scroll
      chatScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
