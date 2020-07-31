import 'package:Biquer/constants.dart';
import 'package:Biquer/model/transaction/TransactionData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionsScreen extends StatelessWidget {
  final String categoryID, userID;

  TransactionsScreen(this.userID, {this.categoryID});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactionsStream(context),
    );
  }

  StreamBuilder transactionsStream(BuildContext context) {
    TransactionData transactionData = TransactionData();
    return transactionData.defaultBuilder(
        transactionData.findUserTransactions(this.userID),
        emptyResult: Column(
          children: [
            FadeInImage(
                placeholder: AssetImage(''), image: NetworkImage(kNoJobsImage)),
            Text(
              'Você ainda não fez nenhum bico',
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ],
        ));
  }
}
