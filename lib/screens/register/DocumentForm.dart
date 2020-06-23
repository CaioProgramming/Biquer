import 'dart:io';

import 'package:Biquer/components/PageTitle.dart';
import 'package:Biquer/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';

class DocumentForm extends StatefulWidget {
  @override
  _DocumentFormState createState() => _DocumentFormState();
}

class _DocumentFormState extends State<DocumentForm> {
  File _documentFront, _documentVerse;
  final picker = ImagePicker();

  Future pickDocumentFront() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _documentFront = File(pickedFile.path);
    });
  }

  Future pickDocumentVerse() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _documentVerse = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            PageTitle('Documentos', kDocumentMessage),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.phone,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ], // Only numbers can be entered
                decoration: InputDecoration(
                    hintText: 'Número do documento(CPF, RG ou CNPJ)',
                    hintStyle: TextStyle(color: Theme.of(context).hintColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    )),
              ),
            ),
            GestureDetector(
              onTap: pickDocumentFront,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: kFileInputDecoration,
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Icon(
                          _documentFront == null
                              ? FlutterIcons.id_badge_faw5
                              : FlutterIcons.check_faw,
                          color: Colors.blue,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          _documentFront == null
                              ? 'Enviar frente do documento'
                              : 'Foto enviada',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w400,
                              fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: pickDocumentVerse,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: kFileInputDecoration,
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Icon(
                          _documentVerse == null
                              ? FlutterIcons.id_badge_faw5s
                              : FlutterIcons.check_faw5s,
                          color: Colors.blue,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          _documentVerse == null
                              ? 'Enviar verso do documento'
                              : 'Foto enviada',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w400,
                              fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
