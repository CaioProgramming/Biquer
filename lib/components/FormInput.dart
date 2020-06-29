import 'package:Biquer/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormInput extends StatelessWidget {
  final bool readonly, obscureText, maxLenghtEnforced, autofocus;
  final Function textChange, onSubmit;
  final String hintText, errorText;
  final TextInputAction inputAction;
  final List<TextInputFormatter> inputFormatter;
  final TextInputType keyBoardType;
  final int maxlenght;

  FormInput(this.textChange,
      {this.readonly = false,
      this.onSubmit,
      this.hintText,
      this.obscureText = false,
      this.inputAction,
      this.inputFormatter,
      this.errorText,
      this.maxlenght,
      this.maxLenghtEnforced = false,
      this.autofocus = false,
      this.keyBoardType});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: kDefaultMargin,
      child: TextField(
        readOnly: readonly,
        obscureText: obscureText,
        inputFormatters: inputFormatter,
        textInputAction: inputAction ?? TextInputAction.none,
        onChanged: textChange,
        onSubmitted: (newText) => onSubmit(newText),
        maxLength: maxlenght,
        maxLengthEnforced: maxLenghtEnforced,
        keyboardType: keyBoardType,
        decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: kDefaultBorder,
            )),
      ),
    );
  }
}
