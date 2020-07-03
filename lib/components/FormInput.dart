import 'package:Biquer/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormInput extends StatelessWidget {
  final bool readonly, obscureText, maxLenghtEnforced, autofocus;
  final Function textChange, onSubmit;
  final String hintText, labelText, errorText;
  final TextInputAction inputAction;
  final List<TextInputFormatter> inputFormatter;
  final TextInputType keyBoardType;
  final int maxlenght;
  final Widget sufixIcon;

  FormInput(this.textChange,
      {this.readonly = false,
      this.onSubmit,
      this.sufixIcon,
      @required this.hintText,
      this.labelText,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            child: Text(
              labelText ?? hintText,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).hintColor),
            ),
          ),
          TextField(
            readOnly: readonly,
            obscureText: obscureText,
            inputFormatters: inputFormatter,
            textInputAction: inputAction ?? TextInputAction.none,
            onChanged: (newText) {
              textChange(newText);
            },
            onSubmitted: (newText) {
              onSubmit(newText);
            },
            maxLength: maxlenght,
            maxLengthEnforced: maxLenghtEnforced,
            keyboardType: keyBoardType,
            enabled: !readonly,
            decoration: InputDecoration(
                hintText: hintText,
                errorText: errorText ?? null,
                suffixIcon: sufixIcon,
                border: OutlineInputBorder(
                  borderRadius: kDefaultBorder,
                )),
          ),
        ],
      ),
    );
  }
}
