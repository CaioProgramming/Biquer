import 'dart:io';

import 'package:Biquer/components/MessageBubble.dart';
import 'package:Biquer/components/PickerOptions.dart';
import 'package:Biquer/components/service/ServicerTypeCard.dart';
import 'package:Biquer/constants.dart';
import 'package:Biquer/model/RegisterData.dart';
import 'package:Biquer/model/document/Document.dart';
import 'package:Biquer/model/user/User.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

enum DocumentStage { selectype, docid, docUrl }

class DocumentData {
  Future<String> uploadDoc(Document document, String uid) async {
    print('uploading doc ${document.id} -> ${document.docURL}');
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
      default:
        return '';
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
                  height: 120,
                  width: 120,
                ),
                onSelect: () {
                  var _biquerData =
                      Provider.of<RegisterData>(context, listen: false);
                  _biquerData.sendData(UserType.individual);
                },
                backColor: Colors.black,
                textColor: Colors.white,
              ),
              ServicerTypeCard(
                typename: 'Empresa',
                userType: UserType.company,
                image: SvgPicture.asset(
                  'images/team.svg',
                  height: 120,
                  width: 120,
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
          decoration: kMessageFieldDecoration.copyWith(hintText: hint),
        );
        break;
      default:
        return PickerOptions((dynamic file) => onFilePick(file));
        break;
    }
  }
}
