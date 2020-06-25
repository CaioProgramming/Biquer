import 'dart:io';

import 'package:Biquer/components/BaseForm.dart';
import 'package:Biquer/components/FormInput.dart';
import 'package:Biquer/components/PageTitle.dart';
import 'package:Biquer/constants.dart';
import 'package:Biquer/model/Address.dart';
import 'package:Biquer/model/CEP.dart';
import 'package:Biquer/model/CepData.dart';
import 'package:Biquer/model/RegisterData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddressForm extends StatefulWidget {
  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  File _addressProof;
  final picker = ImagePicker();
  CEP cepData;
  bool error = false;

  Future pickAddressProof() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _addressProof = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    int number;
    RegisterData registerData =
        Provider.of<RegisterData>(context, listen: true);
    return BaseForm([
      PageTitle(
          'Endereço',
          cepData == null
              ? kAddressMessage
              : 'Muito bem, envie um comprovante de endereço e verifique se as informações estão corretas antes de prosseguir.'),
      Container(
        margin: kDefaultMargin,
        child: cepData == null
            ? SizedBox()
            : Center(
                child: MaterialButton(
                  onPressed: pickAddressProof,
                  elevation: 0,
                  padding: EdgeInsets.all(0),
                  child: Container(
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                            colors: _addressProof == null
                                ? [Colors.lightBlue, Colors.blueAccent]
                                : [Colors.green, Colors.greenAccent])),
                    child: Row(
                      children: [
                        Icon(
                          _addressProof == null
                              ? AntDesign.cloudupload
                              : AntDesign.check,
                          size: 32,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          _addressProof == null
                              ? 'Enviar comprovante de endereço'
                              : 'Comprovante enviado',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
      FormInput(
        null,
        onSubmit: (newText) => getCepData(newText),
        inputAction: TextInputAction.go,
        inputFormatter: [WhitelistingTextInputFormatter.digitsOnly],
        maxlenght: 8,
        maxLenghtEnforced: true,
        keyBoardType: TextInputType.phone,
        hintText: 'CEP',
      ),
      cepData != null
          ? cepData.showCepInfo(context, (newValue) {
              number = int.parse(newValue);
              setState(() {});
            })
          : SizedBox(),
      cepData != null
          ? Center(
              child: MaterialButton(
                onPressed: () {
                  registerData.userAddress =
                      Address(cepData.cep, number, _addressProof.path);
                },
                child: _addressProof == null
                    ? SizedBox()
                    : Text(
                        'Confirmar informações',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.green),
                      ),
              ),
            )
          : SizedBox()
    ]);
  }

  void getCepData(String cepInput) async {
    var cepHelper = CepHelper(cepInput);
    cepData = await cepHelper.getCepInfo();
    print('cep updated $cepData');
    error = cepData == null;
    setState(() {});
  }
}
