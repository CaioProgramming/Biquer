import 'package:Biquer/components/MessageBubble.dart';

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

  List<MessageBubble> cepMessages() {
    List<MessageBubble> cepbubbles = [];
    if (state != null)
      cepbubbles.add(
          MessageBubble(messageChild: MessageBubble.defaultMessageText(state)));

    if (street != null)
      cepbubbles.add(MessageBubble(
          messageChild: MessageBubble.defaultMessageText(street)));

    if (neighborhood != null)
      cepbubbles.add(MessageBubble(
          messageChild: MessageBubble.defaultMessageText(neighborhood)));

    if (city != null)
      cepbubbles.add(
          MessageBubble(messageChild: MessageBubble.defaultMessageText(city)));

    return cepbubbles;
  }
}
