import 'package:Biquer/model/ServiceData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'PageTitle.dart';
import 'ServiceCard.dart';

class ServicePreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ServiceData serviceData = Provider.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PageTitle('Prévia',
            'Assim que seu serviço irá aparecer para os usuários, escolha um estilo que ficará visível no seu serviço, deslize para o lado para ver os estilos disponíveis'),
        serviceData.category() != null && serviceData.category().styles != null
            ? Expanded(child: ServiceCardPreview())
            : ServiceCard.defaultCard(serviceData.service),
      ],
    );
  }
}
