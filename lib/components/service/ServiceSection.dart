import 'package:Biquer/model/service/BicoData.dart';
import 'package:Biquer/model/service/Service.dart';
import 'package:Biquer/model/service/ServiceData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../PageTitle.dart';

class ServiceSection extends StatelessWidget {
  final String categoryKey;

  ServiceSection(this.categoryKey);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PageTitle('Serviço', 'Selecione um serviço relacionado'),
        Expanded(child: _servicesStream(categoryKey, context)),
      ],
    );
  }

  StreamBuilder _servicesStream(String categoryID, BuildContext context) {
    BicoData bicoData = Provider.of(context);
    ServiceData serviceStore = ServiceData(categoryID: categoryKey);
    return serviceStore.defaultBuilder(serviceStore.defaultStream(),
        selectedService: bicoData.service,
        emptyResult: Text('Serviços não encontrados'),
        cardPress: (Service s) => bicoData.updateService(s));
  }
}
