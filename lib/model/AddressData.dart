import 'dart:io';

import 'package:Biquer/components/MessageBubble.dart';
import 'package:Biquer/components/PickerOptions.dart';
import 'package:Biquer/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'Address.dart';

enum AddressStage { cep, number, proof }

class AddressData {
  Future<String> uploadDoc(Address address, String uid) async {
    print('uploading doc ${address.cep} -> ${address.urlComprovAddress}');

    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('$uid/documents/address${address.cep}');
    File image = File(address.urlComprovAddress);
    if (!image.existsSync()) {
      return Future.error('Erro ao encontrar foto');
    }
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    print('File Uploaded');
    return await storageReference.getDownloadURL();
  }

  List<MessageBubble> loadAddressMessages() {
    List<MessageBubble> messages = [];
    MessageBubble helloBubble = MessageBubble(
        messageChild: Text(
          'Ok, hora de enviar seus dados de endereço.',
          style: TextStyle(color: Colors.white),
        ),
        messageType: MessageType.reply);
    MessageBubble cepBubble = MessageBubble(
        messageChild: Text(
          'Vamos começar enviando o CEP',
          style: TextStyle(color: Colors.white),
        ),
        messageType: MessageType.reply);

    messages.add(helloBubble);
    messages.add(cepBubble);

    return messages;
  }

  static String getHint(AddressStage addressStage) {
    switch (addressStage) {
      case AddressStage.cep:
        return 'Escreve seu cep...';
        break;
      case AddressStage.number:
        return 'Escreve seu número...';
        break;
      case AddressStage.proof:
        return 'Envie o comprovante de endereço...';
        break;
    }
  }

  static Widget addressField(AddressStage addressStage, Function onFilePick,
      TextEditingController editingController, BuildContext context) {
    String hint = getHint(addressStage);

    switch (addressStage) {
      case AddressStage.cep:
        var cepMask = new MaskTextInputFormatter(
            mask: '#####-###', filter: {"#": RegExp(r'[0-9]')});
        return TextField(
          controller: editingController,
          textInputAction: TextInputAction.go,
          keyboardType: TextInputType.phone,
          inputFormatters: [cepMask],
          decoration: kMessageFieldDecoration.copyWith(hintText: hint),
        );
        break;
      case AddressStage.number:
        return TextField(
          controller: editingController,
          textInputAction: TextInputAction.go,
          keyboardType: TextInputType.phone,
          inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
          decoration: kMessageFieldDecoration.copyWith(hintText: hint),
        );
        break;
      case AddressStage.proof:
        return PickerOptions((dynamic file) async {
          onFilePick(file);
        });
        break;
    }
  }
}
