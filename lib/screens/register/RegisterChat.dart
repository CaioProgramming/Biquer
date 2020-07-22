import 'dart:async';

import 'package:Biquer/components/PickerOptions.dart';
import 'package:Biquer/model/AddressData.dart';
import 'package:Biquer/model/DocumentData.dart';
import 'package:Biquer/model/RegisterData.dart';
import 'package:Biquer/model/UserData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

import '../../utils.dart';

class RegisterChat extends StatefulWidget {
  @override
  _RegisterChatState createState() => _RegisterChatState();
}

class _RegisterChatState extends State<RegisterChat> {
  final GlobalKey<SliverAnimatedListState> _listKey =
      GlobalKey<SliverAnimatedListState>();

  Widget messageField() {
    switch (_biquerData.stage) {
      case RegisterStage.user:
        return UserData.userField(
            _biquerData.userStage, messageTextController, context);
        break;
      case RegisterStage.address:
        return AddressData.addressField(
            _biquerData.addressStage,
            (dynamic file) => sendData(value: file),
            messageTextController,
            context);
        break;
      case RegisterStage.document:
        return DocumentData.documentField(
            _biquerData.documentStage, _biquerData.myUser.type, (dynamic file) {
          sendData(value: file);
        }, messageTextController, context);
        break;
      case RegisterStage.photo:
        return PickerOptions((dynamic file) => _biquerData.sendData(file));
        break;
      case RegisterStage.saving:
        return CupertinoActivityIndicator();
        break;

      case RegisterStage.complete:
        return MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          padding: EdgeInsets.all(16),
          child: Text(
            'Concluir cadastro',
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.green,
        );
        break;
    }
    return SizedBox();
  }

  void load() async {
    Future.delayed(Duration(seconds: 2), () {
      _biquerData = Provider.of<RegisterData>(context);
      _biquerData.initializeRegister();
      loading = false;
      setState(() {});
    });
  }

  RegisterData _biquerData;
  bool loading = true;
  final _controller = ScrollController();
  final messageTextController = TextEditingController();

  // ignore: missing_return
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
      case RegisterStage.saving:
        return false;
        break;
    }
  }

  void sendData({value}) {
    print('sending data');
    _biquerData.sendData(value ?? messageTextController.text);
    messageTextController.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    if (!loading) {
      Timer(
        Duration(seconds: 1),
        () {
          _controller.animateTo(
            _controller.position.maxScrollExtent,
            curve: Curves.easeIn,
            duration: const Duration(milliseconds: 300),
          );
        },
      );
    }

    return Scaffold(
      body: loading
          ? Center(child: CupertinoActivityIndicator())
          : SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: CustomScrollView(
                      controller: _controller,
                      slivers: [
                        SliverAppBar(
                          expandedHeight: 200,
                          pinned: true,
                          backgroundColor: Utils.barcolor(context),
                          leading: IconButton(
                            icon: Icon(AntDesign.arrowleft),
                            onPressed: () => Navigator.pop(context),
                          ),
                          flexibleSpace: FlexibleSpaceBar(
                            centerTitle: true,
                            titlePadding: EdgeInsets.only(left: 16),
                            title: Row(
                              children: [
                                FadeInImage(
                                    width: 100,
                                    height: 100,
                                    fadeInDuration: Duration(seconds: 1),
                                    placeholder: AssetImage(''),
                                    image: AssetImage('images/deboramoji.png')),
                                Text('Debora'),
                              ],
                            ),
                            background: Container(
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (context, index) => _biquerData.messages[index],
                              childCount: _biquerData.messages.length),
                          key: _listKey,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: showSendButton()
                          ? Theme.of(context).hintColor.withOpacity(0.05)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: messageField(),
                        ),
                        Visibility(
                          visible: showSendButton(),
                          child: FloatingActionButton(
                            elevation: 0,
                            backgroundColor: Colors.lightBlue,
                            onPressed: () =>
                                sendData(value: messageTextController.text),
                            child: Icon(
                              FlutterIcons.paper_plane_ent,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
