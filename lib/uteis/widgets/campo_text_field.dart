import 'package:flutter/material.dart';


// ignore: must_be_immutable
class CampoTextFormField extends StatelessWidget {
  String textoLabel;
  String textoDica;
  bool  passaword;
  TextEditingController? controlador;
  FormFieldValidator<String>? validador;
  TextInputType teclado;
  FocusNode? marcadoFoco;
  FocusNode? recebedorFoco;

  //Tentativa de fazer o onSubmitted
  Function? funcao;


  CampoTextFormField(
      this.textoLabel,
      {super.key, this.textoDica = "",
        this.passaword = false,
        this.controlador,
        this.validador,
        this.teclado = TextInputType.text,
        this.marcadoFoco,
        this.recebedorFoco,
        this.funcao}){
    validador ??= (String? text){
        if(text!.isEmpty) {
          return "'$textoLabel' vazio";
        }
        return null;
      };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      validator: validador,
      obscureText: passaword,
      controller: controlador,
      keyboardType: teclado,
      textInputAction: TextInputAction.next,
      focusNode: marcadoFoco,
      onFieldSubmitted: (String text) {
        if (recebedorFoco != null) {
          FocusScope.of(context).requestFocus(recebedorFoco);
        } else {
          funcao?.call();
        }
      },
      style: TextStyle(
        fontSize: 25,
        color: theme.textTheme.bodyLarge?.color,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: textoLabel,
        labelStyle: TextStyle(
          fontSize: 25,
          color: theme.textTheme.bodyMedium?.color,
        ),
        hintText: textoDica,
        hintStyle: TextStyle(
          fontSize: 15,
          color: theme.hintColor,
        ),
      ),
    );
  }
}