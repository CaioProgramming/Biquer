import 'package:flutter/material.dart';

class BaseForm extends StatelessWidget {
  final List<Widget> childs;

  BaseForm(
    this.childs,
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: childs,
        ),
      ),
    );
  }
}
