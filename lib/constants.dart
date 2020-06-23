import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BoxDecoration kFileInputDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.grey.withOpacity(0.25));
String kDocumentMessage =
    'Hora de enviar uma foto de seus documentos. Lembre-se de fotografar corretamente, para que sua aprovação ocorra o mais rápido possível.';

String kSelfieMessage =
    'Perfeito! Para concluir tire uma selfie com o documento';
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
