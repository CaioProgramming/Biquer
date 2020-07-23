import 'package:Biquer/model/service/Service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'file:///C:/Users/cacai/StudioProjects/Biquer/lib/model/service/ServiceData.dart';

import '../PageTitle.dart';
import 'ServiceCard.dart';

class ServicePreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ServiceData serviceData = Provider.of(context);
    Widget serviceCard() {
      Service service = serviceData.service;
      if (!service.hasData()) {
        return Center(
          child: Column(
            children: [
              Image.network(
                'https://blush.ly/ZrpDm76QX/p',
              ),
              Text(
                'Termine de informar os dados do seu bico',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        );
      } else if (!service.hasCategory()) {
        ServiceCard.defaultCard(service);
      }
      return ServiceCardPreview();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PageTitle('Prévia',
            'Assim que seu serviço irá aparecer para os usuários, escolha um estilo que ficará visível no seu serviço, deslize para o lado para ver os estilos disponíveis da sua categoria!'),
        Expanded(child: serviceCard())
      ],
    );
  }
}
