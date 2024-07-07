import 'package:flutter/material.dart';

//Isolamento das funções de navegação para melhor utilização, já é costume meu usar assim.
Future push(BuildContext context, Widget page, {bool replace = false}) {
  if (replace) {
    return Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }));
  }
  return Navigator.push(context,
      MaterialPageRoute(builder: (BuildContext context) {
    return page;
  }));
}

void pop(BuildContext context, {String? mensagem}) {
  if (mensagem == null) {
    Navigator.of(context).pop();
  } else {
    Navigator.pop(context, mensagem);
  }
}
