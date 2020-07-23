class Address {
  String cep, urlComprovAddress;
  var number;

  Address({this.cep, this.number, this.urlComprovAddress});

  Map<String, dynamic> map() {
    return {
      'cep': this.cep,
      'urlComprovAddress': this.urlComprovAddress,
      'number': this.number
    };
  }

  bool addressComplete() =>
      cep != null &&
      cep.isNotEmpty &&
      urlComprovAddress != null &&
      urlComprovAddress.isNotEmpty &&
      number != null;
}
