import 'dart:convert';

import 'package:Biquer/constants.dart';
import 'package:Biquer/model/CEP.dart';
import 'package:http/http.dart' as http;

class CepHelper {
  String cepRequest;

  CepHelper(this.cepRequest);

  Future<CEP> getCepInfo() async {
    try {
      String url = '$kCepHelperURL$cepRequest$kCEPHelperJsonReturn';
      print('requesting -> $url');
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        print(response.body);
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
