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

import '../../utils.dart';

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
  final GlobalKey<SliverAnimatedListState> _listKey =
      GlobalKey<SliverAnimatedListState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
          return AddressData.addressField(
              _biquerData.addressStage,
              (dynamic file) => sendData(value: file),
              messageTextController,
              context);
          break;
        case RegisterStage.document:
          return DocumentData.documentField(
              _biquerData.documentStage, _biquerData.myUser.type,
                  (dynamic file) {
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
    }

    //After 1 second, it takes you to the bottom of the ListView
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
                    expandedHeight: 100,
                    pinned: true,
                    centerTitle: true,
                    leading: IconButton(
                      icon: Icon(AntDesign.arrowleft),
                      onPressed: () => Navigator.pop(context),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      title: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FadeInImage(
                              width: 50,
                              height: 50,
                              placeholder: AssetImage('images/chick.png'),
                              image: AssetImage('images/deboramoji.png')),
                          Text(
                            'Debora Profil',
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline6,
                          ),
                        ],
                      ),
                      background: Container(
                        color: Utils.barcolor(context),
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
                    ? Theme
                    .of(context)
                    .hintColor
                    .withOpacity(0.05)
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
}
