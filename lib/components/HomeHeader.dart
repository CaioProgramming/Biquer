import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final String caption, title;

  HomeHeader({this.caption, this.title});

  @override
  Widget build(BuildContext context) {
    return this.caption != null && this.title != null
        ? Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    caption,
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(fontSize: 20),
                  ),
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                  )
                ],
              ),
            ),
          )
        : SizedBox();
  }
}
