import 'dart:developer';

import 'package:Biquer/components/service/ServiceCard.dart';
import 'package:Biquer/constants.dart';
import 'package:Biquer/model/BaseData.dart';
import 'package:Biquer/model/service/Service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ServiceData extends BaseData {
  String categoryID;

  ServiceData({this.categoryID});

  Future<Widget> findUserServices(String userID, Widget emptyResult) async {
    QuerySnapshot snapshot = await firestoreInstance
        .collectionGroup(kBicosReference)
        .where("userID", isEqualTo: userID)
        .getDocuments();

    if (snapshot != null) {
      List<Service> userServices = [];
      await Future.forEach(snapshot.documents, (job) async {
        DocumentSnapshot serviceSnapshot =
            await job.reference.parent().parent().get();
        if (serviceSnapshot != null) {
          userServices.add(Service.fromMap(
              serviceSnapshot.data, serviceSnapshot.documentID));
        }
      });
      if (userServices.isNotEmpty) {
        return GridView.builder(
            itemCount: userServices.length,
            shrinkWrap: true,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
            itemBuilder: (context, position) =>
                ServiceCard(service: userServices[position]));
      } else {
        return emptyResult;
      }
    }
  }

  @override
  CollectionReference collectionReference() => firestoreInstance
      .collection(kCategoryReference)
      .document(categoryID)
      .collection(kServiceReference);

  @override
  StreamBuilder<QuerySnapshot> defaultBuilder(Stream<dynamic> stream,
      {Widget emptyResult}) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          final servicesDocuments = snapshot.data.documents;
          if (servicesDocuments.isNotEmpty) {
            return GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1),
                itemCount: servicesDocuments.length,
                itemBuilder: (context, index) {
                  Service service = Service.fromMap(
                      servicesDocuments[index].data,
                      servicesDocuments[index].documentID);
                  return service == null
                      ? Text('Erro ao recuperar serviço')
                      : ServiceCard(service: service);
                });
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
