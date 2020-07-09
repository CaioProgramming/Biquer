import 'dart:io';

import 'package:Biquer/components/MessageBubble.dart';
import 'package:Biquer/components/PickerOptions.dart';
import 'package:Biquer/components/ServicerTypeCard.dart';
import 'package:Biquer/model/Document.dart';
import 'package:Biquer/model/User.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import 'RegisterData.dart';

enum DocumentStage { selectype, docid, docUrl }

class DocumentData {
  Future<String> uploadDoc(Document document, String uid) async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('$uid/documents/docproof${document.id}');
    File image = File(document.docURL);
    if (!image.existsSync()) {
      return Future.error('Erro ao encontrar foto');
    }
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    print('File Uploaded');
    return await storageReference.getDownloadURL();
  }

  Future<List<MessageBubble>> docMessages(Function onSelect) async {
    List<MessageBubble> messages = [];

    messages.add(MessageBubble(
        messageChild: MessageBubble.defaultMessageText(
            'Antes de enviar seus documentos precisa selecionar a opção em que se encontra')));
/*
    messages.add(MessageBubble(
      messageChild: Wrap(
        children: [
          ServicerTypeCard(
            typename: 'Autonômo',
            image: SvgPicture.asset(
              'images/lonely.svg',
              height: 50,
              width: 50,
            ),
            onSelect: () {
              var type = UserType.individual;
              onSelect(type);
            },
            backColor: Colors.black,
            textColor: Colors.lightBlue,
          ),
          ServicerTypeCard(
            typename: 'Empresa',
            userType: UserType.company,
            image: SvgPicture.asset(
              'images/team.svg',
              height: 50,
              width: 50,
            ),
            onSelect: () {
              var type = UserType.company;
              onSelect(type);
            },
            backColor: Colors.deepPurple,
            textColor: Colors.white,
          ),
        ],
      ),
      backcolor: Colors.transparent,
    ));
*/

    return messages;
  }

  static String getHint(DocumentStage documentStage, UserType userType) {
    switch (documentStage) {
      case DocumentStage.selectype:
        return '';
        break;
      case DocumentStage.docid:
        if (userType == UserType.individual) {
          return 'Escreva seu cpf...';
        } else {
          return 'Escreva seu cnpj...';
        }
        break;
      case DocumentStage.docUrl:
        // TODO: Handle this case.
        break;
    }
  }

  static Widget documentField(
    DocumentStage documentStageStage,
    UserType userType,
    Function onFilePick,
    TextEditingController editingController,
    BuildContext context, {
    Function onTypeSelect,
  }) {
    String hint = getHint(documentStageStage, userType);
    var cpfmask = MaskTextInputFormatter(
        mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});
    var cnpjmask = MaskTextInputFormatter(
        mask: '##.###.###/###-##', filter: {"#": RegExp(r'[0-9]')});
    switch (documentStageStage) {
      case DocumentStage.selectype:
        return Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ServicerTypeCard(
                typename: 'Autonômo',
                image: SvgPicture.asset(
                  'images/lonely.svg',
                  height: 50,
                  width: 50,
                ),
                onSelect: () {
                  var _biquerData = Provider.of<RegisterData>(context);
                  _biquerData.sendData(UserType.individual);
                },
                backColor: Colors.black,
                textColor: Colors.lightBlue,
              ),
              ServicerTypeCard(
                typename: 'Empresa',
                userType: UserType.company,
                image: SvgPicture.asset(
                  'images/team.svg',
                  height: 50,
                  width: 50,
                ),
                onSelect: () {
                  var _biquerData = Provider.of<RegisterData>(context);
                  _biquerData.sendData(UserType.company);
                },
                backColor: Colors.deepPurple,
                textColor: Colors.white,
              ),
            ],
          ),
        );
        break;
      case DocumentStage.docid:
        return TextField(
          controller: editingController,
          textInputAction: TextInputAction.go,
          keyboardType: TextInputType.phone,
          inputFormatters: [
            userType == UserType.individual ? cpfmask : cnpjmask
          ],
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).hintColor.withOpacity(0.30),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(style: BorderStyle.none, width: 0)),
            hintText: hint,
          ),
        );
        break;
      case DocumentStage.docUrl:
        return PickerOptions((path) => onFilePick(path));
        break;
    }
  }
}
