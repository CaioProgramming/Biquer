import 'package:flutter/material.dart';

class SavingScreen extends StatelessWidget {
  final String message;
  final String image;

  SavingScreen({this.message, this.image});

  @override
  Widget build(BuildContext context) {
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
