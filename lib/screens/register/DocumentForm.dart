import 'package:Biquer/components/BaseForm.dart';
import 'package:Biquer/components/PickerOptions.dart';
import 'package:Biquer/model/RegisterData.dart';
import 'package:Biquer/model/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class DocumentForm extends StatefulWidget {
  @override
  _DocumentFormState createState() => _DocumentFormState();
}

class _DocumentFormState extends State<DocumentForm> {
  UserType selected = UserType.individual;

  void updateDocData(String doc) async {
    RegisterData registerData =
        Provider.of<RegisterData>(context, listen: true);
    registerData.updateDocID(doc);
  }

  Widget title() {
    if (selected == UserType.individual) {
      return Column(
        children: [
          Text(
            'Documento autônomo',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
            textAlign: TextAlign.center,
          ),
          Text(
            'Preencha seu cpf e envie uma foto do documento(RG ou CNH)',
            style: Theme.of(context)
                .textTheme
                .caption
                .copyWith(color: Colors.white.withOpacity(0.50)),
            textAlign: TextAlign.center,
          ),
        ],
      );
    } else if (selected == UserType.company) {
      return Column(
        children: [
          Text(
            'Documento empresa',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
            textAlign: TextAlign.center,
          ),
          Text(
            'Preencha seu cnpj e envie uma foto ou pdf do comprovante de inscrição estadual',
            style: Theme.of(context)
                .textTheme
                .caption
                .copyWith(color: Colors.white.withOpacity(0.50)),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    return Column(
      children: [
        Text(
          'Documento',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
          textAlign: TextAlign.center,
        ),
        Text(
          'Suas informações não serão compartilhadas externamente.',
          style: Theme.of(context)
              .textTheme
              .caption
              .copyWith(color: Colors.white.withOpacity(0.50)),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget input() {
    if (selected == UserType.company) {
      return Column(
        children: [
          TextField(
            autofocus: true,
            onChanged: (newText) {
              setState(() {
                updateDocData(newText);
              });
            },
            inputFormatters: [
              MaskTextInputFormatter(
                  mask: '##.###.###/###-##', filter: {"#": RegExp(r'[0-9]')})
            ],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.phone,
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(color: Colors.white, fontWeight: FontWeight.w100),
            decoration:
                InputDecoration(border: InputBorder.none, hintText: 'CNPJ'),
          ),
        ],
      );
    }
    return Column(
      children: [
        TextField(
          autofocus: true,
          inputFormatters: [
            MaskTextInputFormatter(
                mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')})
          ],
          onChanged: (newText) {
            print(newText);
            updateDocData(newText);
          },
          textAlign: TextAlign.center,
          keyboardType: TextInputType.phone,
          style: Theme
              .of(context)
              .textTheme
              .headline3
              .copyWith(color: Colors.white, fontWeight: FontWeight.w100),
          decoration:
          InputDecoration(border: InputBorder.none, hintText: 'CPF'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm([
      Wrap(
        alignment: WrapAlignment.center,
        children: [
          UserTypeCard(
            typename: 'Autonômo',
            image: SvgPicture.asset(
              'images/lonely.svg',
              width: selected == UserType.individual ? 160 : 130,
              height: selected == UserType.individual ? 160 : 130,
            ),
            onSelect: () {
              selected = UserType.individual;
              setState(() {});
            },
            selected: selected == UserType.individual,
          ),
          UserTypeCard(
            typename: 'Empresa',
            image: SvgPicture.asset(
              'images/team.svg',
              width: selected == UserType.company ? 160 : 130,
              height: selected == UserType.company ? 160 : 130,
            ),
            onSelect: () {
              setState(() {
                selected = UserType.company;
              });
            },
            selected: selected == UserType.company,
          ),
        ],
      ),
      title(),
      input(),
      PickerOptions((PickedFile file) {
        Provider.of<RegisterData>(context, listen: true)
            .updateDocURL(file.path);
      })
    ]);
  }
}

class UserTypeCard extends StatelessWidget {
  final String typename;
  final bool selected;
  final Function onSelect;
  final SvgPicture image;

  UserTypeCard({@required this.image,
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      image,
                      Text(
                        typename,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: selected
                                ? Colors.white
                                : Theme
                                .of(context)
                                .textTheme
                                .bodyText1
                                .color),
                      ),
                    ],
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
