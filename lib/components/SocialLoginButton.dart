import 'package:Biquer/constants.dart';
import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final Function onTap;

  SocialLoginButton(this.title, this.icon,
      {@required this.onTap,
      this.backColor,
      this.iconColor,
      this.textStyle,
      this.borderColor});

  final String title;
  final IconData icon;
  final Color backColor, iconColor, borderColor;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      child: MaterialButton(
        color: backColor,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: kDefaultBorder),
        onPressed: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: iconColor ?? Theme.of(context).textTheme.bodyText1.color,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: textStyle ??
                    Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
      ),
    );
  }
}
