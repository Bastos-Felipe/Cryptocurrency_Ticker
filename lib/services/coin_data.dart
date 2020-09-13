import 'networking.dart';

const apiKey = "apiKey=9D011135-9D9D-4E16-B466-67F114C0EE8E";
const url = "https://rest.coinapi.io/v1/exchangerate";


const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<dynamic> getCoinData(String currency, String cripCurrency) async {
    NetworkHelper networkHelper = NetworkHelper('$url/$cripCurrency/$currency?$apiKey');

    var currencyData = await networkHelper.getData();

    double currencyValue = currencyData['rate'];
    
    return currencyValue;
  }

}
