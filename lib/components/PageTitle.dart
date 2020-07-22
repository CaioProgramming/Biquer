import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final String title, message;
  final Color textColor;

  const PageTitle(this.title, this.message, {this.textColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 40),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            message,
          ),
        ),
      ],
    );
  }
}
