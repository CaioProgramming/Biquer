import 'dart:developer';

import 'package:Biquer/components/service/ServiceCard.dart';
import 'package:Biquer/constants.dart';
import 'package:Biquer/model/BaseData.dart';
import 'package:Biquer/model/Job.dart';
import 'package:Biquer/model/service/Service.dart';
import 'package:Biquer/screens/NewServiceScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServiceData extends BaseData {
  String categoryID;

  ServiceData({this.categoryID});

  Future<Widget> findUserServices(String userID, BuildContext context) async {
    QuerySnapshot snapshot = await firestoreInstance
        .collectionGroup(kBicosReference)
        .where("userID", isEqualTo: userID)
        .getDocuments();
    if (snapshot != null) {
      List<Widget> servicesCards = [];
      await Future.forEach(snapshot.documents, (DocumentSnapshot job) async {
        DocumentSnapshot serviceSnapshot =
            await job.reference.parent().parent().get();
        Job j = Job.fromMap(job.data, job.documentID);
        if (serviceSnapshot != null) {
          servicesCards.add(ServiceCard(
              price: j.price,
              service: Service.fromMap(
                  serviceSnapshot.data, serviceSnapshot.documentID)));
        }
      });

      if (servicesCards.isNotEmpty) {
        servicesCards.add(CupertinoButton(
            child: Center(
                child: Text(
              'Adicionar novo bico',
              textAlign: TextAlign.center,
            )),
            onPressed: () => Navigator.of(context)
                .pushNamed(NewService.screenRoute, arguments: userID)));
        return GridView.builder(
            itemCount: servicesCards.length,
            shrinkWrap: true,
            padding: EdgeInsets.all(0),
            gridDelegate: kServiceGridDelegate,
            itemBuilder: (context, position) => servicesCards[position]);
      }
    }
    return CupertinoButton(
      child: Center(
        child: Text(
          'Adicionar novo bico',
        ),
      ),
      onPressed: () {
        Navigator.pushNamed(context, NewService.screenRoute, arguments: userID);
      },
    );
  }

  @override
  CollectionReference collectionReference() => firestoreInstance
      .collection(kCategoryReference)
      .document(categoryID)
      .collection(kServiceReference);

  @override
  StreamBuilder<QuerySnapshot> defaultBuilder(Stream<dynamic> stream,
      {Widget emptyResult, Function cardPress, Service selectedService}) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          final servicesDocuments = snapshot.data.documents;
          if (servicesDocuments.isNotEmpty) {
            return GridView.builder(
                shrinkWrap: true,
                gridDelegate: kServiceGridDelegate,
                itemCount: servicesDocuments.length,
                itemBuilder: (context, index) {
                  Service service = Service.fromMap(
                      servicesDocuments[index].data,
                      servicesDocuments[index].documentID);
                  return service == null
                      ? Text('Erro ao recuperar serviço')
                      : ServiceCard(
                          selectedService: selectedService,
                          service: service,
                          onServiceSelect: (Service s) => cardPress(service),
                        );
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
