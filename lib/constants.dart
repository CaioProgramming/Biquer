import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

const kServiceReference = "Services";
const kCategoryReference = "Categories";
const kBicosReference = "Jobs";
const kTransactionsReference = "Transactions";
const kUsersReference = "Biquer";
const kClientsReference = "Client";

const kDocumentMessage =
    'Hora de enviar uma foto de seus documentos. Lembre-se de fotografar corretamente, para que sua aprovação ocorra o mais rápido possível.';
const kSelfieMessage =
    'Perfeito! Para concluir tire uma selfie com o documento.';
const kAddressMessage =
    'Insira os dados de seu endereço para prosseguir com o cadastro.';
const kRegistermessage = 'Cadastre-se para começar a divulgar seus serviços!';

const kCepHelperURL = 'https://brasilapi.com.br/api/cep/v1/';
const kDefaultMargin = EdgeInsets.symmetric(vertical: 24);
const kDefaultBorder = BorderRadius.all(Radius.circular(10));

const kSavingServiceIllustration = 'https://blush.ly/htzfMMG4P/p';
const kSavedServiceIllustration = 'https://blush.ly/8-T_F9IJ2/p';
const kErrorServiceIllustration = 'https://blush.ly/iYlgf16yK/p';
const kLoginImage = 'https://blush.ly/F_G_vXq4C/p';
const kNoServiceImage = 'https://blush.ly/ycXBSkED4/p';
const kNoJobsImage = 'https://i.ibb.co/rmfs6Fr/flame-2.png';

const kUserMessageBorder = BorderRadius.only(
  topRight: Radius.circular(0),
  topLeft: Radius.circular(20),
  bottomLeft: Radius.circular(20),
  bottomRight: Radius.circular(20),
);

const kSenderMessageBorder = BorderRadius.only(
  topRight: Radius.circular(20),
  topLeft: Radius.circular(0),
  bottomLeft: Radius.circular(20),
  bottomRight: Radius.circular(20),
);

const kMessageFieldDecoration = InputDecoration(
  border: OutlineInputBorder(
      borderSide: BorderSide(style: BorderStyle.none, width: 0)),
);

const kServiceGridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
    crossAxisCount: 2,
    childAspectRatio: 3 / 6);

const kCategoryGridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisSpacing: 4,
    mainAxisSpacing: 4,
    crossAxisCount: 2,
    childAspectRatio: 3 / 5);

const kbottombarIcons = [
  BottomNavigationBarItem(icon: Icon(FontAwesome.home), title: Text('Home')),
  BottomNavigationBarItem(
      icon: Icon(FontAwesome.bar_chart), title: Text('Transações')),
  BottomNavigationBarItem(
      icon: Icon(FontAwesome.check), title: Text('Serviços')),
  BottomNavigationBarItem(icon: Icon(FontAwesome.user), title: Text('Perfil')),
];
