import 'dart:async';

import 'package:Biquer/components/PickerOptions.dart';
import 'package:Biquer/model/AddressData.dart';
import 'package:Biquer/model/DocumentData.dart';
import 'package:Biquer/model/RegisterData.dart';
import 'package:Biquer/model/UserData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  RegisterData _biquerData;
  bool loading = true;
  final _controller = ScrollController();
  final messageTextController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }

  void load() async {
    Future.delayed(Duration(seconds: 2), () {
      _biquerData = Provider.of<RegisterData>(context);
      _biquerData.initializeRegister();
      loading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget messageField() {
      switch (_biquerData.stage) {
        case RegisterStage.user:
          return UserData.userField(
              _biquerData.userStage, messageTextController, context);
          break;
        case RegisterStage.address:
          return AddressData.addressField(_biquerData.addressStage,
              (path) => sendData(path), messageTextController, context);
          break;
        case RegisterStage.document:
          return DocumentData.documentField(
              _biquerData.documentStage, _biquerData.myUser.type, (path) {
            sendData(path);
          }, messageTextController, context);
          break;
        case RegisterStage.photo:
          return PickerOptions((path) => _biquerData.sendData(path));
          break;
        case RegisterStage.complete:
          return MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Concluir cadastro'),
            color: Colors.green,
          );
          break;
      }
    }

    // After 1 second, it takes you to the bottom of the ListView
    Timer(
      Duration(seconds: 2),
      () {
        _controller.animateTo(
          _controller.position.maxScrollExtent,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: AssetImage('images/deboramoji.jpeg'),
                      fit: BoxFit.cover)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Debora Profil',
                  ),
                  Text(
                    'Online',
                    style: Theme.of(context).textTheme.caption,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      body: loading
          ? Center(child: CupertinoActivityIndicator())
          : SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                        controller: _controller,
                        itemBuilder: (context, index) =>
                            _biquerData.messages[index],
                        itemCount: _biquerData.messages.length,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: showSendButton()
                          ? Theme.of(context).hintColor.withOpacity(0.30)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: messageField(),
                        ),
                        Visibility(
                          visible: showSendButton(),
                          child: IconButton(
                              icon: Icon(FlutterIcons.paper_plane_ent),
                              onPressed: () =>
                                  sendData(messageTextController.text)),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }

  bool showSendButton() {
    switch (_biquerData.stage) {
      case RegisterStage.user:
        return true;
        break;
      case RegisterStage.address:
        return _biquerData.addressStage != AddressStage.proof;
        break;
      case RegisterStage.document:
        return _biquerData.documentStage != DocumentStage.docUrl &&
            _biquerData.documentStage != DocumentStage.selectype;
        break;
      case RegisterStage.photo:
        return false;
        break;
      case RegisterStage.complete:
        return false;
        break;
    }
  }

  void sendData(value) {
    print('sending data');
    _biquerData.sendData(messageTextController.text);
    messageTextController.clear();
  }
}
