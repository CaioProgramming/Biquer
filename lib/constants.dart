import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BoxDecoration kFileInputDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: Colors.blue, style: BorderStyle.solid, width: 2),
    color: Colors.blue.withOpacity(0.10));
const String kDocumentMessage =
    'Hora de enviar uma foto de seus documentos. Lembre-se de fotografar corretamente, para que sua aprovação ocorra o mais rápido possível.';

String kSelfieMessage =
    'Perfeito! Para concluir tire uma selfie com o documento';

const String kRegistermessage =
    'Cadastre-se para começar a divulgar seus serviços!';

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
