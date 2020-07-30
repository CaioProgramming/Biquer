import 'package:Biquer/components/TransactionCard.dart';
import 'package:Biquer/constants.dart';
import 'package:Biquer/model/BaseData.dart';
import 'package:Biquer/model/transaction/BicoTransaction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class TransactionData extends BaseData {
  Stream findUserTransactions(String uid) =>
      query(field: "biqueiroKey", value: uid);

  @override
  CollectionReference collectionReference() =>
      firestoreInstance.collection(kTransactionsReference);

  @override
  StreamBuilder<QuerySnapshot> defaultBuilder(Stream stream,
      {Widget emptyResult}) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final transactionsDocuments = snapshot.data.documents;
          if (transactionsDocuments.isNotEmpty) {
            return ListView.builder(
              itemBuilder: (context, index) {
                BicoTransaction t = BicoTransaction.fromMap(
                    transactionsDocuments[index].data,
                    transactionsDocuments[index].documentID);
                return TransactionCard(bicoTransaction: t);
              },
              itemCount: transactionsDocuments.length,
              shrinkWrap: true,
            );
          } else {
            return emptyResult;
          }
        } else {
          return emptyResult;
        }
      },
    );
  }
}
