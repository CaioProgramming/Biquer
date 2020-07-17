import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

BoxDecoration kFileInputDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: Colors.blue, style: BorderStyle.solid, width: 2),
    color: Colors.blue.withOpacity(0.10));

const kDocumentMessage =
    'Hora de enviar uma foto de seus documentos. Lembre-se de fotografar corretamente, para que sua aprovação ocorra o mais rápido possível.';
const kSelfieMessage =
    'Perfeito! Para concluir tire uma selfie com o documento.';
const kAddressMessage =
    'Insira os dados de seu endereço para prosseguir com o cadastro.';
const kRegistermessage = 'Cadastre-se para começar a divulgar seus serviços!';

const kCepHelperURL = 'https://brasilapi.com.br/api/cep/v1/';
const kDefaultMargin = EdgeInsets.symmetric(vertical: 10);
const kDefaultBorder = BorderRadius.all(Radius.circular(5));

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

LinearGradient kButtonGradient = LinearGradient(
  colors: [
    Colors.blue,
    Colors.blue.shade700,
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
LinearGradient kSuccessButtonGradient = LinearGradient(
  colors: [
    Colors.green,
    Colors.green.shade700,
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
const kbottombarIcons = [
  BottomNavigationBarItem(icon: Icon(AntDesign.home), title: Text('Home')),
  BottomNavigationBarItem(
      icon: Icon(AntDesign.clockcircleo), title: Text('Transações')),
  BottomNavigationBarItem(
      icon: Icon(AntDesign.codepen), title: Text('Serviços')),
  BottomNavigationBarItem(icon: Icon(AntDesign.user), title: Text('Perfil')),
];
