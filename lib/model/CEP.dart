import 'package:Biquer/components/FormInput.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CEP {
  String cep, logradouro, complemento, bairro, localidade, uf;

  CEP(this.cep, this.logradouro, this.complemento, this.bairro, this.localidade,
      this.uf);

  static CEP mapToCep(Map<String, dynamic> map) => CEP(
      map['cep'],
      map['logradouro'],
      map['complemento'],
      map['bairro'],
      map['localidade'],
      map['uf']);

  Widget showCepInfo(BuildContext context, Function numberField) {
    List<Widget> cepWidgets = [];
    if (uf != null)
      cepWidgets.add(FormInput(null, readonly: true, hintText: uf));
    if (logradouro != null)
      cepWidgets.add(FormInput(null, readonly: true, hintText: logradouro));
    cepWidgets.add(FormInput(
      numberField,
      hintText: 'Número',
      keyBoardType: TextInputType.phone,
      autofocus: true,
    ));
    if (bairro != null)
      cepWidgets.add(FormInput(null, readonly: true, hintText: bairro));
    if (localidade != null)
      cepWidgets.add(FormInput(null, readonly: true, hintText: localidade));
    if (complemento != null && complemento.isNotEmpty)
      cepWidgets.add(FormInput(null, readonly: true, hintText: complemento));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: cepWidgets,
    );
  }
}
