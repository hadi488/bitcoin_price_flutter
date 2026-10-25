import 'dart:io' show Platform;

import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData coindata = CoinData();
  String selectedCurrency = 'USD';
  double bitcoinRate = 0.0;
  double ethereumRate = 0.0;
  double litecoinRate = 0.0;
  void updateCurrency(String value) {
    setState(() {
      selectedCurrency = value;
    });
    getBTCData(value);
    getEThData(value);
    getLTCData(value);
  }

  void getBTCData(String selectedCurrency) async {
    try {
      String BTCrate = await coindata.getBTCCoinData(selectedCurrency);
      setState(() {
        bitcoinRate = double.parse(BTCrate);
      });
    } catch (e) {
      print(e);
    }
  }

  void getEThData(String selectedCurrency) async {
    try {
      String ETHrate = await coindata.getETHCoinData(selectedCurrency);
      setState(() {
        ethereumRate = double.parse(ETHrate);
      });
    } catch (e) {
      print(e);
    }
  }

  void getLTCData(String selectedCurrency) async {
    try {
      String LTCrate = await coindata.getLTCCoinData(selectedCurrency);
      setState(() {
        litecoinRate = double.parse(LTCrate);
      });
    } catch (e) {
      print(e);
    }
  }

  DropdownButton<String> getAndroidDropdownButton() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      print("currency: $currency");
      var newItem = DropdownMenuItem(child: Text(currency), value: currency);
      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        print("value: $value");
        updateCurrency(value!);
      },
    );
  }

  CupertinoPicker getIosPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      print("currency: $currency");
      var newItem = Text(currency);
      pickerItems.add(newItem);
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        String IndexToCurrency = currenciesList[selectedIndex];
        updateCurrency(IndexToCurrency);
      },
      children: pickerItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('🤑 Coin Ticker')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CryptoCard(
                cryptoCurrency: "BTC",
                selectedCurrency: selectedCurrency,
                coinRate: bitcoinRate,
              ),
              CryptoCard(
                cryptoCurrency: "ETH",
                selectedCurrency: selectedCurrency,
                coinRate: ethereumRate,
              ),
              CryptoCard(
                cryptoCurrency: "LTC",
                selectedCurrency: selectedCurrency,
                coinRate: litecoinRate,
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? getIosPicker() : getAndroidDropdownButton(),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  final String cryptoCurrency;
  final String selectedCurrency;
  final double coinRate;
  CryptoCard({
    required this.cryptoCurrency,
    required this.selectedCurrency,
    required this.coinRate,
  });

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = ${coinRate} $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
