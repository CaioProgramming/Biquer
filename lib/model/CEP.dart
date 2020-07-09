import 'package:Biquer/components/FormInput.dart';
import 'package:Biquer/components/MessageBubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CEP {
  String cep, state, city, neighborhood, street;

  CEP(
    this.cep,
    this.state,
    this.city,
    this.neighborhood,
    this.street,
  );

  static CEP mapToCep(Map<String, dynamic> map) => CEP(map['cep'], map['state'],
      map['city'], map['neighborhood'], map['street']);

  Widget showCepInfo(BuildContext context) {
    List<Widget> cepWidgets = [];
    if (state != null)
      cepWidgets.add(FormInput(
        null,
        readonly: true,
        hintText: state,
        labelText: 'state',
      ));

    if (neighborhood != null)
      cepWidgets.add(FormInput(null,
          readonly: true, hintText: neighborhood, labelText: 'neighborhood'));
    if (city != null)
      cepWidgets.add(FormInput(
        null,
        readonly: true,
        hintText: city,
        labelText: 'city',
      ));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: cepWidgets ??
          [
            Center(
              child: CupertinoActivityIndicator(),
            )
          ],
    );
  }

  List<MessageBubble> cepMessages() {
    List<MessageBubble> cepbubbles = [];
    if (state != null)
      cepbubbles.add(
          MessageBubble(messageChild: MessageBubble.defaultMessageText(state)));

    if (neighborhood != null)
      cepbubbles.add(MessageBubble(
          messageChild: MessageBubble.defaultMessageText(neighborhood)));
    if (city != null)
      cepbubbles.add(
          MessageBubble(messageChild: MessageBubble.defaultMessageText(city)));

    return cepbubbles;
  }
}
