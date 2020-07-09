import 'dart:async';
import 'dart:io';

import 'package:Biquer/components/MessageBubble.dart';
import 'package:Biquer/model/Address.dart';
import 'package:Biquer/model/AddressData.dart';
import 'package:Biquer/model/Document.dart';
import 'package:Biquer/model/DocumentData.dart';
import 'package:Biquer/model/UserData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils.dart';
import 'CepData.dart';
import 'User.dart';

enum RegisterStage { user, address, document, photo, complete }

class RegisterData extends ChangeNotifier {
  FirebaseUser user;
  RegisterStage stage = RegisterStage.user;
  AddressStage addressStage = AddressStage.cep;
  UserStage userStage = UserStage.email;
  DocumentStage documentStage = DocumentStage.selectype;

  User get myUser => _myUser;

  set myUser(User value) {
    _myUser = value;
  }

  Address _userAddress;
  User _myUser;
  Document _userDocument;

  RegisterData() {
    userAddress = Address();
    _myUser = User();
    _userDocument = Document();
  }

  Address get userAddress => _userAddress;

  set userAddress(Address value) {
    _userAddress = value;
    print('Address updated');
    notifyListeners();
  }

  List<MessageBubble> messages = [];

  void initializeRegister() async {
    var udata = UserData();
    List<MessageBubble> registerMessages =
        await udata.loadRegisterMessages('Debora Profil', (firebaseuser) {
      print('user logged $firebaseuser');
      if (firebaseuser != null) {
        user = firebaseuser;
        sendSuccessMessage(
            'Seus dados foram validados ${user.displayName} vamos prosseguir com o cadastro');
        this.user = firebaseuser;
        stage = RegisterStage.address;
        initializeAddress();
      } else {
        sendReply('Ops parece que algo deu errado durante seu login');
      }
    });
    if (registerMessages == null || registerMessages.isEmpty) {
      sendReply('Ocorreu um erro ao iniciar o chat');
    } else {
      addBubbles(registerMessages);
    }
  }

  void initializeAddress() {
    var addressMessages = AddressData().loadAddressMessages();
    addBubbles(addressMessages);
  }

  Future addBubbles(List<MessageBubble> messageBubbles) async {
    if (messageBubbles.length == 0) {
      sendReply('Só um momento...');
    }
    for (MessageBubble message in messageBubbles) {
      messages.add(message);
      notifyListeners();
      await Future.delayed(Duration(seconds: 2), () {
        print('can add another bubble now');
      });
    }
    print('added ${messages.length} bubbles');
  }

  void updateMessages(Widget child, MessageType messageType) {
    addBubbles([MessageBubble(messageType: messageType, messageChild: child)]);
  }

  void createMessage(MessageBubble bubble) {
    messages.add(bubble);
  }

  void sendData(dynamic msg) {
    handleData(msg);
  }

  void handleData(dynamic data) {
    switch (stage) {
      case RegisterStage.address:
        handleAddress(data);
        break;
      case RegisterStage.user:
        handleUser(data);
        break;
      case RegisterStage.document:
        handleDocument(data);
        break;
      case RegisterStage.photo:
        updateUserPic(data);
        break;
      case RegisterStage.complete:
        sendSuccessMessage('Seu cadastro foi concluído com sucesso!');
        break;
    }
  }

  void handleAddress(String data) {
    switch (addressStage) {
      case AddressStage.cep:
        getCepData(data);
        break;
      case AddressStage.number:
        updateAddressNumber(data);
        break;
      case AddressStage.proof:
        updateAddressURL(data);
        break;
    }
  }

  String useremail, userpass;

  void handleUser(String data) async {
    switch (userStage) {
      case UserStage.email:
        updateUserEmail(data);
        break;
      case UserStage.password:
        await updateUserPass(data);
        break;
    }
  }

  Future updateUserPass(String data) async {
    userpass = data;
    loadMessage();
    user = await UserData().registerWithEmailAndPassword(useremail, userpass);
    messages.removeLast();
    if (user != null) {
      sendSuccessMessage(
          'Seu email foi validado com sucesso ${user.displayName} vamos continuar com o cadastro');
      stage = RegisterStage.address;
      initializeAddress();
    } else {
      sendReply(
          'Ocorreu um erro ao processar seu cadastro, vamos tentar de novo');
      sendReply('Envie seu email');
      userStage = UserStage.email;
    }
    notifyListeners();
  }

  void sendSuccessMessage(String msg) {
    addBubbles([MessageBubble.successMessage(msg)]);
  }

  void updateUserEmail(String data) {
    useremail = data;
    userStage = UserStage.password;
    sendMessage(Text(data));
    sendReply('Ok agora digite sua senha');
    notifyListeners();
  }

  void handleDocument(dynamic data) {
    switch (documentStage) {
      case DocumentStage.selectype:
        updateUserType(data);
        break;
      case DocumentStage.docid:
        updateDocID(data);
        break;
      case DocumentStage.docUrl:
        updateDocURL(data);
        break;
    }
  }

  void updateUserType(data) {
    myUser.type = data;
    documentStage = DocumentStage.docid;
    String type = myUser.type == UserType.individual ? 'CPF' : 'CNPJ';
    sendReply('Ok agora insira seu $type');
  }

  void getCepData(String cepInput) async {
    sendMessage(Text(cepInput));
    loadMessage();
    var cepHelper = CepHelper(cepInput.replaceAll(Utils.intRegex(), ''));
    var cepData = await cepHelper.getCepInfo();
    print('cep updated $cepData');
    var error = cepData == null;
    if (!error) {
      messages.removeLast();
      sendSuccessMessage(
          'Endereço validado com sucesso veja a seguir se as informações estão corretas');
      updateAddressCEP(cepData.cep);
      addBubbles(cepData.cepMessages()).then((value) {
        addressStage = AddressStage.number;
        sendReply('Ok agora envie o número da residência');
      });
    } else {
      messages.removeLast();
      sendReply(
          'Opss, não consegui encontrar seu CEP, poderia digitar novamente?');
      notifyListeners();
    }
  }

  void sendReply(String msg, {Color backcolor}) {
    updateMessages(
        Text(
          msg,
          style: TextStyle(color: Colors.white),
        ),
        MessageType.reply);
  }

  void sendMessage(Widget child) {
    addBubbles([
      MessageBubble(
        messageChild: child,
        messageType: MessageType.send,
      )
    ]);
  }

  void loadMessage() {
    messages.add(MessageBubble(
        messageChild: FadeInImage(
            width: 100,
            height: 100,
            placeholder: AssetImage('images/caiomoji.jpeg'),
            image: AssetImage('images/deboramoji.webp')),
        messageType: MessageType.reply,
        backcolor: Colors.transparent));
    notifyListeners();
  }

  set userDocument(Document value) {
    _userDocument = value;
    print('document updated on provider');
    notifyListeners();
  }

  void updateAddressNumber(String number) {
    userAddress.number = number;
    sendMessage(Text(number));
    addressStage = AddressStage.proof;
    sendReply('Muito bem agora envie um comprovante de endereço');
  }

  void updateDocID(String id) {
    _userDocument.id = id;
    sendData(id);
    documentStage = DocumentStage.docUrl;
    sendReply(
        'Perfeito agora envie a foto de seu documento para comprovar sua identidade');
    print('updated docID $id on provider');
  }

  void updateAddressURL(String url) async {
    _userAddress.urlComprovAddress = url;
    updateMessages(
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: FadeInImage(
              width: 200,
              height: 200,
              placeholder: AssetImage('images/caiomoji.jpeg'),
              image: FileImage(
                File(url),
              )),
        ),
        MessageType.send);
    stage = RegisterStage.document;
    sendReply('Perfeito vamos prosseguir com o cadastro');
    addBubbles(await DocumentData().docMessages((usertype) {
      _myUser.type = usertype;
      if (usertype == UserType.individual) {
        sendReply('Ok agora insira o seu CPF');
      } else {
        sendReply('Ok agora insira seu cnpj');
      }
      documentStage = DocumentStage.docid;
    }));
    documentStage = DocumentStage.selectype;
    notifyListeners();
  }

  void updateDocURL(String url) {
    userAddress.urlComprovAddress = url;
    updateMessages(
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: FadeInImage(
              width: 200,
              height: 200,
              placeholder: AssetImage('images/caiomoji.jpeg'),
              image: FileImage(
                File(url),
              )),
        ),
        MessageType.send);
    sendReply('Perfeito hora da última etapa');

    stage = RegisterStage.photo;
    sendReply(
        'Para finalizar você precisa enviar uma foto de rosto com seu documento em mãos');
    notifyListeners();
  }

  void updateUserPic(String url) async {
    _myUser.safetyPic = url;
    notifyListeners();
    sendReply('Ok isso é tudo vou processar seu cadastro');
    loadMessage();
    bool saved = await saveUserInfo();
    if (saved) {
      sendReply(
          'Seu cadastro foi concluído com sucesso, você já está pronto para usar a bico!');
      stage = RegisterStage.complete;
    } else {
      sendReply(
          'Ocorreu um erro ao processar seu cadastro já estou verificando isso');
    }
  }

  void updateAddressCEP(String cep) {
    userAddress.cep = cep;
    notifyListeners();
    print('cep $cep updated on provider');
  }

  bool userLogged() {
    print('user logged?  ${user != null}');
    return user != null;
  }

  String _userPicURL;

  String get userPicURL => _userPicURL;

  set userPicURL(String value) {
    _userPicURL = value;
    notifyListeners();
  }

  Future<bool> saveUserInfo() async {
    User myuser = User(
        uid: user.uid,
        safetyPic: _userPicURL,
        address: _userAddress,
        document: _userDocument);
    return await UserData().saveUserInfo(myuser, user.displayName.trim());
  }
}
