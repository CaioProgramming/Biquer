import 'dart:io';

import 'package:Biquer/components/BaseForm.dart';
import 'package:Biquer/components/FormInput.dart';
import 'package:Biquer/components/PageTitle.dart';
import 'package:Biquer/constants.dart';
import 'package:Biquer/model/RegisterData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import '../../utils.dart';

class DocumentForm extends StatefulWidget {
  @override
  _DocumentFormState createState() => _DocumentFormState();
}

class _DocumentFormState extends State<DocumentForm> {
  var _documentFront;
  int selected;
  final picker = ImagePicker();

  Future pickDocumentFront() async {
    RegisterData registerData =
        Provider.of<RegisterData>(context, listen: true);
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      print('updating document');
      registerData.updateDocURL(pickedFile.path);
      setState(() {
        _documentFront = File(pickedFile.path);
      });
    }
  }

  void updateDocData(String doc) async {
    RegisterData registerData =
        Provider.of<RegisterData>(context, listen: true);
    registerData.updateDocID(doc);
  }

  mask() {
    if (selected == 0) {
      return MaskTextInputFormatter(
          mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});
    } else {
      print('cnpj mask found');
      return MaskTextInputFormatter(
          mask: '##.###.###/###-##', filter: {"#": RegExp(r'[0-9]')});
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm([
      PageTitle(
          'Documentos',
          selected == null
              ? 'Selecione o tipo de servidor que você é'
              : 'Insira seus dados e envie uma foto com frente e verso de seu documento(RG, CNH ou inscrição estadual).'),
      Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.spaceAround,
        children: [
          UserTypeCard(
            typename: 'Empresa',
            typeImageURl:
                'https://mixkit.imgix.net/art/preview/mixkit-girl-leading-a-team-meeting-at-work-543-square-large.png?w=441&h=441&q=80&auto=format%2Ccompress&q=80&dpr=1',
            selected: selected == 0,
            onSelect: () {
              setState(() {
                selected = 0;
              });
            },
          ),
          UserTypeCard(
            typename: 'Autonômo',
            typeImageURl:
                'https://mixkit.imgix.net/art/preview/mixkit-person-arranging-a-series-of-designs-on-an-office-wall-28-desktop-wallpaper-medium.png?w=390&h=219&q=80&auto=format%2Ccompress&q=80&dpr=1',
            selected: selected == 1,
            onSelect: () {
              setState(() {
                selected = 1;
              });
            },
          )
        ],
      ),
      selected == null
          ? SizedBox()
          : Column(
              children: [
                FormInput(
                  (newText) {
                    updateDocData(newText);
                  },
                  inputAction: TextInputAction.go,
                  hintText: selected == 0 ? 'CPF' : 'CNPJ',
                ),
                Container(
                  margin: kDefaultMargin,
                  child: Center(
                    child: MaterialButton(
                      onPressed: pickDocumentFront,
                      elevation: 0,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(0),
                      child: Container(
                        padding: EdgeInsets.all(24),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 64,
                              backgroundColor: Colors.blue,
                              child: Icon(
                                _documentFront == null
                                    ? Entypo.upload
                                    : AntDesign.check,
                                color: Colors.white,
                                size: 64,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              _documentFront == null
                                  ? 'Enviar documento'
                                  : 'Documento enviado!',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            _documentFront == null
                                ? SizedBox()
                                : Text(
                                    '${Utils.getFileSize(_documentFront)}',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    ]);
  }
}

class UserTypeCard extends StatelessWidget {
  final String typeImageURl, typename;
  final bool selected;
  final Function onSelect;

  UserTypeCard(
      {this.typeImageURl,
      this.typename,
      this.selected,
      @required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedSwitcher(
        duration: Duration(seconds: 1),
        transitionBuilder: (child, animation) =>
            ScaleTransition(scale: animation, child: child),
        child: MaterialButton(
          padding: EdgeInsets.all(0),
          elevation: selected ? 3 : 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: selected ? Colors.blue : Colors.grey.withOpacity(0.30),
          onPressed: onSelect,
          child: Container(
            margin: EdgeInsets.all(4),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(8),
                  width: selected ? 160 : 130,
                  height: selected ? 160 : 130,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          typeImageURl,
                        )),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    typename,
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
