import 'dart:io';

import 'package:Biquer/components/BaseForm.dart';
import 'package:Biquer/components/FormInput.dart';
import 'package:Biquer/components/PageTitle.dart';
import 'package:Biquer/constants.dart';
import 'package:Biquer/model/CEP.dart';
import 'package:Biquer/model/CepData.dart';
import 'package:Biquer/model/RegisterData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import '../../utils.dart';

class AddressForm extends StatefulWidget {
  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  var _addressProof;
  final picker = ImagePicker();
  CEP cepData;
  bool error = false;
  bool loading = false;
  String number;

  File get addressProof => _addressProof;
  var maskFormatter = new MaskTextInputFormatter(
      mask: '#####-###', filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    RegisterData registerData =
        Provider.of<RegisterData>(context, listen: true);
    return BaseForm([
      PageTitle(
          'Endereço',
          cepData == null
              ? kAddressMessage
              : 'Para concluir informe o número da residência e anexe um comprovante de endereço.'),
      FormInput(
        (newText) => getCepData(newText),
        onSubmit: (newText) => getCepData(newText),
        inputAction: TextInputAction.go,
        inputFormatter: [maskFormatter],
        maxlenght: 9,
        maxLenghtEnforced: true,
        keyBoardType: TextInputType.phone,
        hintText: 'CEP',
        errorText: error ? 'Informe o CEP correto' : null,
        sufixIcon: loading && cepData == null
            ? CupertinoActivityIndicator()
            : cepData == null && !loading == null
                ? Icon(
                    AntDesign.close,
                    color: Colors.red,
                  )
                : cepData != null
                    ? Icon(
                        AntDesign.checkcircle,
                        color: Colors.green,
                      )
                    : null,
      ),
      cepData == null
          ? SizedBox()
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Número',
                  style: Theme.of(context).textTheme.caption,
                ),
                TextField(
                  autofocus: true,
                  onChanged: (newText) {
                    updateAddressNumber(newText);
                  },
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.phone,
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(color: Theme.of(context).primaryColor),
                  decoration:
                      InputDecoration(border: InputBorder.none, hintText: '0'),
                ),
                registerData.addressNumber != null &&
                        registerData.addressNumber.isNotEmpty
                    ? MaterialButton(
                        onPressed: pickAddressProof,
                        elevation: 1,
                        padding: EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.blue, width: 1)),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Icon(
                              _addressProof == null
                                  ? AntDesign.clouduploado
                                  : AntDesign.check,
                              color: Colors.blue,
                            ),
                            SizedBox(width: 15),
                            Text(
                              _addressProof == null
                                  ? 'Enviar comprovante de endereço'
                                  : 'Comprovante enviado',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue),
                            )
                          ],
                        ),
                      )
                    : SizedBox()
              ],
            ),
      cepData == null ? SizedBox() : cepData.showCepInfo(context),
    ]);
  }

  void updateAddressNumber(String number) async {
    RegisterData registerData =
        Provider.of<RegisterData>(context, listen: true);
    registerData.updateAddressNumber(number);
  }

  Future pickAddressProof() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      var snack = SnackBar(
        content: Text('Ocorreu um erro ao recuperar o documento'),
      );
      Scaffold.of(context).showSnackBar(snack);
      return null;
    }
    RegisterData registerData =
        Provider.of<RegisterData>(context, listen: true);
    registerData.updateAddressURL(pickedFile.path);
    setState(() {
      _addressProof = pickedFile;
    });
  }

  void getCepData(String cepInput) async {
    setState(() {
      loading = true;
    });
    if (cepInput.length != 9) {
      setState(() {
        cepData = null;
        loading = false;
      });

      return;
    }

    var cepHelper = CepHelper(cepInput.replaceAll(Utils.intRegex(), ''));
    cepData = await cepHelper.getCepInfo();
    print('cep updated $cepData');
    error = cepData == null;
    if (!error) {
      RegisterData registerData =
          Provider.of<RegisterData>(context, listen: true);
      registerData.updateAddressCEP(cepData.cep);
      FocusScope.of(context).nextFocus();
    }
    setState(() {
      loading = false;
    });
  }
}
