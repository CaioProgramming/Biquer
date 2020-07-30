import 'dart:io';

import 'package:Biquer/components/MessageBubble.dart';
import 'package:Biquer/constants.dart';
import 'package:Biquer/model/BaseData.dart';
import 'package:Biquer/model/RegisterData.dart';
import 'package:Biquer/model/address/AddressData.dart';
import 'package:Biquer/model/document/DocumentData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'User.dart';

enum UserStage { name, email, password }

class UserData extends BaseData {
  Future<bool> saveUserInfo(
      User user, String name, RegisterData registerData) async {
    AddressData addressData = AddressData();
    DocumentData documentData = DocumentData();
    String address = await addressData.uploadDoc(user.address, user.uid);
    String document = await documentData.uploadDoc(user.document, user.uid);
    String profilepicture = await uploadPic(user.safetyPic, user.uid, name);
    user.address.urlComprovAddress = address;
    user.document.docURL = document;
    user.safetyPic = profilepicture;
    print('$address\n$document\n$profilepicture');
    if (address == null || document == null) {
      return Future.error(
          'Erro ao recuperar informações de endereço e documento');
    }
    bool success = false;
    await collectionReference()
        .document(user.uid)
        .setData(user.map())
        .catchError((onError) {
      success = false;
      print(onError);
    }).whenComplete(() => success = true);
    return success;
  }

  Future<String> uploadPic(String url, String uid, String name) async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('$uid/documents/profile$name');
    File image = File(url);
    if (!image.existsSync()) {
      return Future.error('Erro ao encontrar foto\n$url');
    }
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    print('File Uploaded');
    return await storageReference.getDownloadURL();
  }

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final _auth = FirebaseAuth.instance;
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    return user;
  }

  Future<FirebaseUser> signInWithEmailAndPassword(String email,
      String password) async {
    FirebaseUser user;

    try {
      final _auth = FirebaseAuth.instance;
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = result.user;
    } catch (e) {
      print(e);
      return null;
    }
    return user;
  }

  Future<FirebaseUser> registerWithEmailAndPassword(String useremail,
      userpassword) async {
    try {
      final _auth = FirebaseAuth.instance;

      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
          email: useremail, password: userpassword);
      FirebaseUser newUser = authResult.user;
      newUser.sendEmailVerification();

      return newUser;
    } on PlatformException catch (e) {
      print(e.code);
      print(e);
      return null;
    }
  }

  Future<List<MessageBubble>> loadRegisterMessages(
      String operator, Function onSignInListener) async {
    List<MessageBubble> messages = [];
    MessageBubble helloBubble = MessageBubble(
        messageChild: Text(
          'Olá, meu nome é $operator, vou te ajudar a realizar seu cadastro.',
          style: TextStyle(color: Colors.white),
        ),
        messageType: MessageType.reply);
    MessageBubble optionsBubble = MessageBubble(
        messageChild: Text(
          'Você pode realizar seu cadastro enviando as informações que vou solicitar ou utilizando sua conta google',
          style: TextStyle(color: Colors.white),
        ),
        messageType: MessageType.reply);
    MessageBubble googleOptionBubble = MessageBubble(
        messageChild: Text(
          'Se preferir utilizar sua conta Google clique na próxima mensagem',
          style: TextStyle(color: Colors.white),
        ),
        messageType: MessageType.reply);
    MessageBubble googleSignInBubble = MessageBubble(
      messageChild: IconButton(
          icon: Icon(
            MaterialCommunityIcons.google,
            color: Colors.white,
          ),
          onPressed: () async {
            FirebaseUser user = await signInWithGoogle();
            onSignInListener(user);
          }),
      messageType: MessageType.reply,
      backcolor: Colors.blue,
    );
    MessageBubble emailBubble = MessageBubble(
        messageChild: Text(
          'Se deseja utilizar o seu email vamos começar enviando seu nome completo',
          style: TextStyle(color: Colors.white),
        ),
        messageType: MessageType.reply);

    messages.add(helloBubble);
    messages.add(optionsBubble);
    messages.add(googleOptionBubble);
    messages.add(googleSignInBubble);
    messages.add(emailBubble);
    print('${messages.length} register messages');
    return messages;
  }

  static Widget userField(UserStage userStage,
      TextEditingController editingController, BuildContext context) {
    String hint =
        userStage == UserStage.email ? 'Escreva seu email' : 'Digite uma senha';

    return TextField(
      controller: editingController,
      style: TextStyle(color: Colors.white),
      obscureText: userStage == UserStage.password,
      textInputAction: TextInputAction.go,
      keyboardType: userStage == UserStage.email
          ? TextInputType.emailAddress
          : TextInputType.visiblePassword,
      decoration: kMessageFieldDecoration.copyWith(hintText: hint),
    );
  }

  @override
  CollectionReference collectionReference() =>
      firestoreInstance.collection(kUsersReference);

  @override
  StreamBuilder<QuerySnapshot> defaultBuilder(Stream stream,
      {Widget emptyResult}) {
    // TODO: implement defaultBuilder
    throw UnimplementedError();
  }
}
