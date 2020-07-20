import 'package:Biquer/model/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ServicerTypeCard extends StatelessWidget {
  final String typename;
  final Function onSelect;
  final Color backColor, textColor;
  final SvgPicture image;
  final UserType userType;

  ServicerTypeCard(
      {@required this.image,
      this.typename,
      this.userType = UserType.individual,
      @required this.backColor,
      @required this.textColor,
      @required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        padding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: backColor,
        onPressed: onSelect,
        child: Container(
          margin: EdgeInsets.all(4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    image,
                    Text(
                      typename,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: textColor,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
