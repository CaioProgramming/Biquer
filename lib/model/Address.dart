class Address {
  String cep, urlComprovAdress;
  var number;

  Address({this.cep, this.number, this.urlComprovAdress});

  bool addressComplete() =>
      cep != null &&
      cep.isNotEmpty &&
      urlComprovAdress != null &&
      urlComprovAdress.isNotEmpty &&
      number != null &&
      number.isNotEmpty;
}
