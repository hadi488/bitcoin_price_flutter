import 'dart:convert';

import 'package:bitcoin_ticker/constants.dart';
import 'package:http/http.dart' as http;

class CoinData {
  Future<String> getBTCCoinData(String selectedCurrency) async {
    String requestURL = '${coinAPIURL}btc-bitcoin?quotes=$selectedCurrency';
    http.Response response = await http.get(Uri.parse(requestURL));
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      double lastPrice = decodedData['quotes'][selectedCurrency]['price'];
      return lastPrice.toStringAsFixed(1);
    } else {
      print(response.statusCode);
      throw 'Problem with the get request';
    }
  }

  Future<String> getETHCoinData(String selectedCurrency) async {
    String requestURL = '${coinAPIURL}eth-ethereum?quotes=$selectedCurrency';
    http.Response response = await http.get(Uri.parse(requestURL));
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      double lastPrice = decodedData['quotes'][selectedCurrency]['price'];
      return lastPrice.toStringAsFixed(1);
    } else {
      print(response.statusCode);
      throw 'Problem with the get request';
    }
  }

  Future<String> getLTCCoinData(String selectedCurrency) async {
    String requestURL = '${coinAPIURL}ltc-litecoin?quotes=$selectedCurrency';
    http.Response response = await http.get(Uri.parse(requestURL));
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      double lastPrice = decodedData['quotes'][selectedCurrency]['price'];
      return lastPrice.toStringAsFixed(1);
    } else {
      print(response.statusCode);
      throw 'Problem with the get request';
    }
  }
}
