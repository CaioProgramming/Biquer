import 'package:Biquer/model/Job.dart';
import 'package:Biquer/model/service/BicoData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../PageTitle.dart';

class ServicePreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BicoData serviceData = Provider.of(context);
    Widget serviceCard() {
      Job bico = serviceData.bico;
      if (!bico.hasData()) {
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
      } else {
        return Center(
          child: Column(
            children: [
              Text(
                'Seu bico foi incluído com sucesso!',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        );
      }
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
