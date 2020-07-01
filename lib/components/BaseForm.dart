import 'package:flutter/material.dart';

class BaseForm extends StatelessWidget {
  final List<Widget> childs;

  BaseForm(this.childs);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: AnimatedSwitcher(
          duration: Duration(seconds: 1),
          transitionBuilder: (child, animation) =>
              ScaleTransition(scale: animation, child: child),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: childs,
          ),
        ),
      ),
    );
  }
}
