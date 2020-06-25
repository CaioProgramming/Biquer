import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final String title, message;

  const PageTitle(this.title, this.message);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 40),
        ),
        Text(
          message,
        ),
      ],
    );
  }
}
