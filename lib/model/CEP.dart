import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  Widget showCepInfo(BuildContext context) {
    return Column(
      children: [
        Visibility(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.phone,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
              textInputAction: TextInputAction.go,
              decoration: InputDecoration(
                  hintText: uf,
                  hintStyle: TextStyle(color: Theme.of(context).hintColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  )),
            ),
          ),
        ),
        Visibility(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              readOnly: true,
              keyboardType: TextInputType.phone,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
              textInputAction: TextInputAction.go,
              decoration: InputDecoration(
                  hintText: logradouro,
                  hintStyle: TextStyle(color: Theme.of(context).hintColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  )),
            ),
          ),
        ),
        Visibility(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.phone,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
              textInputAction: TextInputAction.go,
              autofocus: true,
              decoration: InputDecoration(
                  hintText: 'Número',
                  hintStyle: TextStyle(color: Theme.of(context).hintColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  )),
            ),
          ),
        ),
        Visibility(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              readOnly: true,
              keyboardType: TextInputType.phone,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
              textInputAction: TextInputAction.go,
              decoration: InputDecoration(
                  hintText: bairro,
                  hintStyle: TextStyle(color: Theme.of(context).hintColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  )),
            ),
          ),
        ),
        Visibility(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              readOnly: true,
              keyboardType: TextInputType.phone,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
              textInputAction: TextInputAction.go,
              decoration: InputDecoration(
                  hintText: localidade,
                  hintStyle: TextStyle(color: Theme.of(context).hintColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  )),
            ),
          ),
        ),
        Visibility(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.phone,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
              textInputAction: TextInputAction.go,
              decoration: InputDecoration(
                  hintText: complemento.isEmpty ? 'Complemento' : complemento,
                  hintStyle: TextStyle(color: Theme.of(context).hintColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
