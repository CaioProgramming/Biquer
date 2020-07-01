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
import 'package:simple_animations/simple_animations.dart';

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

  File get addressProof => _addressProof;

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
    if (registerData.userAddress == null) registerData.userAddress = Address();
    registerData.userAddress.urlComprovAdress = pickedFile.path;
    setState(() {
      _addressProof = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    RegisterData registerData =
    Provider.of<RegisterData>(context, listen: true);
    final tween = MultiTrackTween([
      Track("main").add(
          Duration(milliseconds: 500),
          ColorTween(
              begin: _addressProof == null ? Colors.lightBlue : Colors.green,
              end: _addressProof == null
                  ? Colors.blue[600]
                  : Colors.green[600])),
      Track("accent").add(
          Duration(seconds: 1),
          ColorTween(
              begin: _addressProof == null ? Colors.teal : Colors.greenAccent,
              end: _addressProof == null
                  ? Colors.tealAccent.shade700
                  : Colors.greenAccent.shade700))
    ]);
    return BaseForm([
      PageTitle(
          'Endereço',
          cepData == null
              ? kAddressMessage
              : 'Para concluir informe o número da residência e anexe um comprovante de endereço.'),
      AnimatedContainer(
        duration: Duration(seconds: 1),
        margin: kDefaultMargin,
        child: cepData == null
            ? SizedBox()
            : Center(
          child: MaterialButton(
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
                      fontWeight: FontWeight.w600, color: Colors.blue),
                )
              ],
            ),
                ),
              ),
      ),
      FormInput(
            (newText) => getCepData(newText),
        onSubmit: (newText) => getCepData(newText),
        inputAction: TextInputAction.go,
        inputFormatter: [WhitelistingTextInputFormatter.digitsOnly],
        maxlenght: 8,
        maxLenghtEnforced: true,
        keyBoardType: TextInputType.phone,
        hintText: 'CEP',
        errorText: 'Informe o CEP correto',
        sufixIcon: loading && cepData == null
            ? CupertinoActivityIndicator()
            : cepData == null
            ? Icon(
          AntDesign.close,
          color: Colors.red,
        )
            : Icon(
          AntDesign.checkcircle,
          color: Colors.green,
        ),
      ),
      cepData == null
          ? SizedBox()
          : cepData.showCepInfo(context, (numberField) {
        registerData.updateAddressNumber(numberField);
      }),
    ]);
  }

  void getCepData(String cepInput) async {
    if (cepInput.length != 8) return;
    setState(() {
      loading = true;
    });
    var cepHelper = CepHelper(cepInput);
    cepData = await cepHelper.getCepInfo();
    print('cep updated $cepData');
    error = cepData == null;
    if (!error) {
      RegisterData registerData =
      Provider.of<RegisterData>(context, listen: true);
      if (registerData.userAddress == null)
        registerData.userAddress = Address();
      registerData.userAddress.cep = cepData.cep;
    }
    setState(() {
      loading = false;
    });
  }
}
