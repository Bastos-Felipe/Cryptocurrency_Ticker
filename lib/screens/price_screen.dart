import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../services/coin_data.dart';
import 'package:bitcoin_ticker/components/crypto_Card.dart';

class PriceScreen extends StatefulWidget {
  PriceScreen({this.currencyData});

  final currencyData;

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData coinData = CoinData();
  var selectedCurrency = 'AUD';
  int btc;
  int eth;
  int ltc;
  List<double> cryptoValues = [];
  bool isWaiting = false;

  void updateScreen(
    List<double> currencyData,
  ) {
    setState(() {
      btc = currencyData[0].toInt();
      eth = currencyData[1].toInt();
      ltc = currencyData[2].toInt();
      isWaiting = false;
    });
  }

  @override
  void initState() {
    super.initState();
    updateScreen(widget.currencyData);
  }

  List<Text> getDropdownItems() {
    List<Text> dropdownItems = [];

    for (String currency in currenciesList) {
      dropdownItems.add(
        Text(
          currency,
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return dropdownItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Cryptocurrency Ticker')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CryptoCard(
                      cryptoCurrency: 'BTC',
                      cryptoValue: isWaiting ? '?' :  btc,
                      currency: selectedCurrency),
                  CryptoCard(
                      cryptoCurrency: 'ETH',
                      cryptoValue: isWaiting ? '?' :  eth,
                      currency: selectedCurrency),
                  CryptoCard(
                      cryptoCurrency: 'LTC',
                      cryptoValue: isWaiting ? '?' :  ltc,
                      currency: selectedCurrency),
                ],
              )),

          // Padding(
          //   padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
          //   child: Card(
          //     color: Colors.blueGrey,
          //     elevation: 5.0,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(10.0),
          //     ),
          //     child: Padding(
          //       padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          //       child: Text(
          //         '1 BTC = $btc $selectedCurrency',
          //         textAlign: TextAlign.center,
          //         style: TextStyle(
          //           fontSize: 20.0,
          //           color: Colors.white,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.blueGrey,
              child: CupertinoPicker(
                itemExtent: 20,
                onSelectedItemChanged: (selectedIndex) async {
                  setState(() {
                    isWaiting = true;
                    selectedCurrency = currenciesList[selectedIndex];
                  });
                  cryptoValues.clear();
                  try {
                    for (String cryptoCoin in cryptoList) {
                      double cryptoData = await coinData.getCoinData(
                          selectedCurrency, cryptoCoin);
                      cryptoValues.add(cryptoData);
                    }
                    // double btcData =
                    //     await coinData.getCoinData(selectedCurrency, 'BTC');
                    updateScreen(cryptoValues);
                  } catch (e) {
                    print(e);
                  }
                },
                children: getDropdownItems(),
              )),
        ],
      ),
    );
  }
}
