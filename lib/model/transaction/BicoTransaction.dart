import 'package:cloud_firestore/cloud_firestore.dart';

class BicoTransaction {
  DocumentReference client, biquer, service;
  double value;
  String key;

  BicoTransaction(
      {this.client, this.biquer, this.value, this.service, this.key});

  factory BicoTransaction.fromMap(Map<String, dynamic> map, String key) {
    return new BicoTransaction(
        client: map['client'] as DocumentReference,
        biquer: map['biquer'] as DocumentReference,
        value: map['value'] as double,
        service: map['service'] as DocumentReference,
        key: key);
  }

  Map<String, dynamic> toMap() {
    return {
      'client': this.client,
      'servicer': this.biquer,
      'value': this.value,
      'service': this.service,
    };
  }
}
