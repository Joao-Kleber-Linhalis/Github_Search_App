import 'package:flutter/material.dart';

class Botao extends StatelessWidget {
  final VoidCallback onPressed;
  final String texto;

  Botao({required this.onPressed, required this.texto});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Determine se o tema atual é claro ou escuro
    final isDarkMode = theme.brightness == Brightness.dark;

    // Defina os temas opostos para o botão
    final lightButtonTheme = ElevatedButton.styleFrom(
      foregroundColor: Colors.black,
      backgroundColor: Colors.white, // Texto preto para tema claro
    );

    final darkButtonTheme = ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.black, // Texto branco para tema escuro
    );

    // Escolha o tema do botão com base no tema atual
    final buttonTheme = isDarkMode ? lightButtonTheme : darkButtonTheme;

    return ElevatedButton(
      style: buttonTheme,
      onPressed: onPressed,
      child: Text(texto),
    );
  }
}
