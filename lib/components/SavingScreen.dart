import 'package:flutter/material.dart';

class SavingScreen extends StatelessWidget {
  final String message;
  final String image;
  final Function callBack;

  SavingScreen({this.message, this.image, this.callBack});

  @override
  Widget build(BuildContext context) {
    callBack();

    return Container(
      height: double.maxFinite,
      child: Center(
        child: Column(
          children: [
            Image.network(
              image,
              height: 300,
              width: 300,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                message,
                style: Theme.of(context).textTheme.headline5,
              ),
            )
          ],
        ),
      ),
    );
  }
}
