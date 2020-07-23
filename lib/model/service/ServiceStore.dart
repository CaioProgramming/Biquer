import 'package:Biquer/components/service/ServiceCard.dart';
import 'package:Biquer/constants.dart';
import 'package:Biquer/model/BaseData.dart';
import 'package:Biquer/model/service/Service.dart';
import 'package:Biquer/screens/NewServiceScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServiceStore extends BaseData {
  FirebaseUser _user;

  ServiceStore(this._user);

  @override
  String reference() => "Services";

  Future<Widget> getServices(BuildContext context) async {
    Widget widget = CupertinoActivityIndicator();
    QuerySnapshot querySnapshot = await query(value: _user.uid, field: "user");
    var documents = querySnapshot.documents;
    if (documents.isNotEmpty) {
      List<Widget> serviceCards = [];
      {
        serviceCards.clear();
        await Future.forEach(documents, (serviceDoc) async {
          Service service =
              await Service.withStyle(serviceDoc.data, serviceDoc.documentID);
          serviceCards.add(ServiceCard(
            service: service,
          ));
          print('added ${service.name}');
        });
        serviceCards.add(Center(
          child: CupertinoButton(
              child: Text(
                'Adicionar novo serviço',
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                Navigator.pushNamed(context, NewService.screenRoute,
                    arguments: _user);
              }),
        ));
        widget = GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                childAspectRatio: 2 / 4),
            itemBuilder: (context, index) {
              return serviceCards[index];
            },
            itemCount: serviceCards.length);
      }
    } else {
      widget = Center(
        child: Column(
          children: [
            FadeInImage(
              placeholder: AssetImage(''),
              fadeInDuration: Duration(seconds: 1),
              fit: BoxFit.cover,
              image: NetworkImage(kNoServiceImage),
            ),
            Text(
                'Você não possui nenhum bico até o momento, clique no botão abaixo para adicionar um novo'),
            CupertinoButton(
                child: Text('Novo bico'),
                onPressed: () => Navigator.pushNamed(
                    context, NewService.screenRoute,
                    arguments: _user))
          ],
        ),
      );
    }
    return widget;
  }
}
