import 'package:flutter/material.dart';

class BaseForm extends StatelessWidget {
  final List<Widget> childs;
  final bool padding;

  BaseForm(this.childs, {this.padding = true});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: padding ? EdgeInsets.all(16) : EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: childs,
        ),
      ),
    );
  }
}
