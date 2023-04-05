import 'package:flutter/material.dart';

class MessageFieldBox extends StatelessWidget {

  // Poder emitir el valor que el botón envía
  final ValueChanged<String> onValue;

  const MessageFieldBox({
    super.key, 
    required this.onValue,
  });

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();

    // Mantener el foco
    final focusNode = FocusNode();

    final outlineInputBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(40),
    );

    final inputDecoration = InputDecoration(
      hintText: 'Pregunta con un signo de interrogación al final "?"',
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      filled: true,
      suffixIcon: IconButton(
        onPressed: () {
          final textValue = textController.value.text;
          textController.clear();
          // Llamar el método onValue que se envía desde el padre
          onValue(textValue);
        },
        icon: const Icon(Icons.send_outlined),
      ),
    );

    return TextFormField(
      onTapOutside: (event) {
        focusNode.unfocus();
      },
      focusNode: focusNode,
      controller: textController,
      decoration: inputDecoration,
      onFieldSubmitted: (value) {
        textController.clear();
        focusNode.requestFocus();
        onValue(value);
      },
    );
  }
}
