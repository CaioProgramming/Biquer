import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  final String title;
  final Widget section;

  Section({this.title, this.section});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 0),
          child: Text(
            title,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
        ),
        Container(
          child: section,
          margin: EdgeInsets.all(10),
        )
      ],
    );
  }
}
