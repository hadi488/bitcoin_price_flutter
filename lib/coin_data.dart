import 'dart:convert';

import 'package:bitcoin_ticker/constants.dart';
import 'package:http/http.dart' as http;

class CoinData {
  Future<String> getCoinData({
    required String selectedCurr,
    required String cryptoCurrencyCode,
  }) async {
    print("selectedCurr: $selectedCurr");
    print("cryptoCurrencyCode: $cryptoCurrencyCode");
    String requestURL =
        '${coinAPIURL}${cryptoCurrencyCode}?quotes=$selectedCurr';
    print("requestURL: $requestURL");
    try {
      http.Response response = await http.get(Uri.parse(requestURL));
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double lastPrice = decodedData['quotes'][selectedCurr]['price'];
        return lastPrice.toStringAsFixed(1);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    } catch (e) {
      print(e);
      throw 'Problem with the get request';
    }
  }
}
