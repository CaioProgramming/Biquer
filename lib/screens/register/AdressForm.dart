import 'dart:io';

import 'package:Biquer/components/PageTitle.dart';
import 'package:Biquer/constants.dart';
import 'package:Biquer/model/CEP.dart';
import 'package:Biquer/model/CepData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';

class AddressForm extends StatefulWidget {
  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  File _documentFront, _documentVerse;
  final picker = ImagePicker();
  CEP cepData;
  bool error = false;

  Future pickDocumentFront() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _documentFront = File(pickedFile.path);
    });
  }

  Future pickDocumentVerse() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _documentVerse = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            PageTitle(
                'Endereço',
                cepData == null
                    ? kAddressMessage
                    : 'Muito bem, verifique se as informações estão corretas antes de prosseguir'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.phone,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                maxLength: 8,
                maxLengthEnforced: true,
                textInputAction: TextInputAction.go,
                onSubmitted: (cepData) => getCepData(cepData),
                decoration: InputDecoration(
                    hintText: 'CEP',
                    errorText: error
                        ? 'Ops! Parece que seu CEP está incorreto!'
                        : null,
                    hintStyle: TextStyle(color: Theme.of(context).hintColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    )),
              ),
            ),
            cepData != null ? cepData.showCepInfo(context) : SizedBox(),
            GestureDetector(
              onTap: pickDocumentVerse,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: kFileInputDecoration,
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Icon(
                          _documentVerse == null
                              ? FlutterIcons.home_faw5s
                              : FlutterIcons.check_faw5s,
                          color: Colors.blue,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          _documentVerse == null
                              ? 'Enviar comprovante de endereço'
                              : 'Foto enviada',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getCepData(String cepInput) async {
    var cepHelper = CepHelper(cepInput);
    cepData = await cepHelper.getCepInfo();
    print('cep updated $cepData');
    error = cepData == null;
    setState(() {});
  }
}
