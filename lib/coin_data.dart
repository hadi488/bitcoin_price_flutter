import 'dart:convert';

import 'package:bitcoin_ticker/constants.dart';
import 'package:http/http.dart' as http;

class CoinData {
  Future<List<Map<String, dynamic>>> getCoinData({
    required String selectedCurr,
  }) async {
    String requestURL = "$coinAPIURL?quotes=$selectedCurr";
    try {
      http.Response response = await http.get(Uri.parse(requestURL));
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        var selectedIds = cryptoList.map((cryptoCoin) {
          return cryptoCoin.values.first;
        }).toSet();
        var selectedCoins = decodedData.where((coin) {
          return selectedIds.contains(coin['id']);
        }).toList();
        List<Map<String, dynamic>> lastPriceOfCoins = selectedCoins
            .map<Map<String, dynamic>>((coin) {
              return {
                'id': coin['id'],
                'price': coin['quotes'][selectedCurr]['price'].toStringAsFixed(
                  1,
                ),
              };
            })
            .toList();
        return lastPriceOfCoins;
      } else {
        throw 'Problem with the get request';
      }
    } catch (e) {
      throw 'Problem with the get request';
    }
  }
}
