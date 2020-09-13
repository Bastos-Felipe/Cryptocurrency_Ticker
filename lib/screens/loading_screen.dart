import 'package:bitcoin_ticker/screens/price_screen.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/services/coin_data.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  List<double> cryptoValues = [];

  @override
  void initState() {
    super.initState();
    getCurrencyData();
  }

  void getCurrencyData() async {
    try {
      for (String cryptoCoin in cryptoList) {
        var coinData = await CoinData().getCoinData('AUD', cryptoCoin);
        cryptoValues.add(coinData);
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return PriceScreen(
              currencyData: cryptoValues,
            );
          },
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
