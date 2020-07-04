import 'dart:io';

import 'package:Biquer/components/PickerOptions.dart';
import 'package:Biquer/model/CEP.dart';
import 'package:Biquer/model/CepData.dart';
import 'package:Biquer/model/RegisterData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
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
  CEP cepData;
  bool error = false;
  bool loading = false;
  String number;

  File get addressProof => _addressProof;
  var maskFormatter = new MaskTextInputFormatter(
      mask: '#####-###', filter: {"#": RegExp(r'[0-9]')});

  Widget title() {
    if (cepData != null && number != null && addressProof == null) {
      return Column(
        children: [
          Text(
            'Comprovante',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
            textAlign: TextAlign.center,
          ),
          Text(
            'Para concluir é só enviar um comprovante de endereço',
            style: Theme.of(context)
                .textTheme
                .caption
                .copyWith(color: Colors.white.withOpacity(0.50)),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }
    if (cepData != null && number != null && addressProof != null) {
      return Column(
        children: [
          Text(
            'Concluído',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
            textAlign: TextAlign.center,
          ),
          Text(
            'Seus dados de endereço foram salvos com sucesso! Continue com o cadastro',
            style: Theme.of(context)
                .textTheme
                .caption
                .copyWith(color: Colors.white.withOpacity(0.50)),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }
    if (cepData != null && number == null) {
      return Column(
        children: [
          Text(
            'Endereço identificado',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
            textAlign: TextAlign.center,
          ),
          Text(
            'Informe o número da residência para prosseguir',
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
          'Informe seu endereço',
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

  @override
  Widget build(BuildContext context) {
    RegisterData registerData =
        Provider.of<RegisterData>(context, listen: true);
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'images/location.svg',
              height: 250,
              width: 250,
            ),
            title(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Visibility(
                child: CupertinoActivityIndicator(),
                visible: loading,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                inputFormatters: [maskFormatter],
                onChanged: (newText) => getCepData(newText),
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'CEP',
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.50)),
                  isDense: false,
                  suffixIcon: cepData == null
                      ? null
                      : Icon(
                          AntDesign.check,
                          color: Colors.green,
                        ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          BorderSide(style: BorderStyle.none, width: 0)),
                ),
              ),
            ),
            Visibility(
              visible: cepData != null,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 40),
                      onChanged: (newText) => updateAddressNumber(newText),
                      keyboardType: TextInputType.phone,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Número',
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.50),
                        ),
                      ),
                    ),
                  ),
                  PickerOptions((PickedFile file) {
                    registerData.updateAddressURL(file.path);
                    setState(() {
                      _addressProof = file;
                    });
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateAddressNumber(String number) async {
    RegisterData registerData =
        Provider.of<RegisterData>(context, listen: true);
    registerData.updateAddressNumber(number);
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
    FocusScope.of(context).nextFocus();
    print('cep updated $cepData');
    error = cepData == null;
    if (!error) {
      RegisterData registerData =
      Provider.of<RegisterData>(context, listen: true);
      registerData.updateAddressCEP(cepData.cep);
    }
    setState(() {
      loading = false;
    });
  }
}
