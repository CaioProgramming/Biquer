import 'dart:convert';

import 'package:Biquer/constants.dart';
import 'package:Biquer/model/CEP.dart';
import 'package:http/http.dart' as http;

import '../utils.dart';

class CepHelper {
  String cepRequest;

  CepHelper(this.cepRequest);

  Future<CEP> getCepInfo() async {
    try {
      cepRequest = cepRequest.replaceAll(Utils.intRegex(), '');
      String url = '$kCepHelperURL$cepRequest';
      print('requesting -> $url');
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        print(response.body);
        if (decodedData['erro'] == true) return null;
        return CEP.mapToCep(decodedData);
      } else {
        print('Response error status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
