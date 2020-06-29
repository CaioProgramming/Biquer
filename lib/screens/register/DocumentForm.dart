import 'dart:io';

import 'package:Biquer/components/BaseForm.dart';
import 'package:Biquer/components/FormInput.dart';
import 'package:Biquer/components/PageTitle.dart';
import 'package:Biquer/constants.dart';
import 'package:Biquer/model/Document.dart';
import 'package:Biquer/model/RegisterData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class DocumentForm extends StatefulWidget {
  @override
  _DocumentFormState createState() => _DocumentFormState();
}

class _DocumentFormState extends State<DocumentForm> {
  File _documentFront, _documentVerse;
  String documentID;
  final picker = ImagePicker();

  Future pickDocumentFront() async {
    RegisterData registerData =
        Provider.of<RegisterData>(context, listen: true);
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    checkRegisterDocument(registerData);
    registerData.userDocument.docURL.add(pickedFile.path);
  }

  Future pickDocumentVerse() async {
    RegisterData registerData =
    Provider.of<RegisterData>(context, listen: true);
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    checkRegisterDocument(registerData);
    registerData.userDocument.docURL.add(pickedFile.path);
  }

  bool docComplete() =>
      _documentFront != null && _documentVerse != null && documentID != null;

  @override
  Widget build(BuildContext context) {
    RegisterData registerData =
        Provider.of<RegisterData>(context, listen: true);
    return BaseForm([
      PageTitle('Documentos',
          'Envie duas fotos com a frente e o verso de seu documento(RG, CNH ou inscrição estadual).'),
      FormInput(
        (newText) {
          checkRegisterDocument(registerData);
          registerData.userDocument.id = newText;
        },
        inputAction: TextInputAction.go,
        inputFormatter: [WhitelistingTextInputFormatter.digitsOnly],
        keyBoardType: TextInputType.phone,
        hintText: 'CPF ou CNPJ',
      ),
      Container(
        margin: kDefaultMargin,
        child: Center(
          child: MaterialButton(
            onPressed: pickDocumentFront,
            elevation: 0,
            padding: EdgeInsets.all(0),
            child: Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                      colors: _documentFront == null
                          ? [Colors.purple, Colors.purpleAccent]
                          : [Colors.green, Colors.greenAccent])),
              child: Row(
                children: [
                  Icon(
                    _documentFront == null ? AntDesign.idcard : AntDesign.check,
                    size: 32,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    _documentFront == null
                        ? 'Enviar frente do documento'
                        : 'Documento enviado!',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      Container(
        margin: kDefaultMargin,
        child: Center(
          child: MaterialButton(
            onPressed: pickDocumentVerse,
            elevation: 0,
            padding: EdgeInsets.all(0),
            child: Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                      colors: _documentVerse == null
                          ? [Colors.deepPurple, Colors.deepPurpleAccent]
                          : [Colors.green, Colors.greenAccent])),
              child: Row(
                children: [
                  Icon(
                    _documentVerse == null
                        ? AntDesign.profile
                        : AntDesign.check,
                    size: 32,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    _documentVerse == null
                        ? 'Enviar verso do documento'
                        : 'Documento enviado!',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  void checkRegisterDocument(RegisterData registerData) {
    if (registerData.userDocument == null)
      registerData.userDocument = Document();
  }
}
