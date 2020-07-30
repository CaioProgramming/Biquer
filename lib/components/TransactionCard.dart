import 'package:Biquer/model/transaction/BicoTransaction.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final BicoTransaction bicoTransaction;

  TransactionCard({this.bicoTransaction});

  @override
  Widget build(BuildContext context) {
    return bicoTransaction == null
        ? SizedBox()
        : ListTile(
            contentPadding: EdgeInsets.all(4),
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('images/debavatar.jpeg'),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Debora',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                Text(
                  'Desenvolvimento de app',
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(fontSize: 14),
                )
              ],
            ),
            trailing: Text(
              '+ 1500,00',
              style: TextStyle(color: Colors.green),
            ),
            dense: true,
          );
  }
}
