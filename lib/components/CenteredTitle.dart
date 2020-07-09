import 'package:flutter/material.dart';

class CenteredTitle extends StatelessWidget {
  final String title, subtitle;
  final Color textColor;

  CenteredTitle({@required this.title, this.subtitle, this.textColor});

  Color defaultColor(BuildContext context) {
    return Theme.of(context).textTheme.headline3.color;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40,
              color: textColor ?? defaultColor(context)),
          textAlign: TextAlign.center,
        ),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.caption.copyWith(
              color: textColor == null
                  ? defaultColor(context).withOpacity(0.50)
                  : textColor.withOpacity(0.50)),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
