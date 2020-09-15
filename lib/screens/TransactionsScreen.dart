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
        emptyResult: Opacity(
          opacity: 0.50,
          child: Text(
            'Você ainda não fez nenhum bico',
            style: Theme.of(context).textTheme.headline6,
          ),
        ));
  }
}
