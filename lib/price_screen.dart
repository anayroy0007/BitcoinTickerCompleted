import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'constants.dart';
import 'dart:io'show Platform;
import 'networking.dart';




class PriceScreen extends StatefulWidget {

  @override
  _PriceScreenState createState() => _PriceScreenState();
}



class _PriceScreenState extends State<PriceScreen> {

  String selectedcurrency =  'USD';
  Future<dynamic> btcdata() async {
    var url = 'https://rest.coinapi.io/v1/exchangerate/${cryptoList.elementAt(0)}/$selectedcurrency?apikey=$apikey';
    NetworkHelper networkHelper = NetworkHelper(url: url);
    var cryptodata = await networkHelper.getData();
    setState(() {
      valuebtc = cryptodata['rate'];
    });
  }//maybe
  Future<dynamic> ethdata() async {
    var url = 'https://rest.coinapi.io/v1/exchangerate/${cryptoList.elementAt(1)}/$selectedcurrency?apikey=$apikey';
    NetworkHelper networkHelper = NetworkHelper(url: url);
    var cryptodata = await networkHelper.getData();
    setState(() {
      valueeth = cryptodata['rate'];
    });
  }//maybe
  Future<dynamic> ltcdata() async {
    var url = 'https://rest.coinapi.io/v1/exchangerate/${cryptoList.elementAt(2)}/$selectedcurrency?apikey=$apikey';
    NetworkHelper networkHelper = NetworkHelper(url: url);
    var cryptodata = await networkHelper.getData();
    setState(() {
      valueltc = cryptodata['rate'];
    });
  }//maybe

  DropdownButton<String> androiddropdownbutton(){
    List<DropdownMenuItem<String>> dropdownitems = [];
    for(String currency in currenciesList ) {
      var currencies = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownitems.add(currencies);
    }
    return DropdownButton<String>(
      value: selectedcurrency,
      style: kDropdowntextstyle,
      items: dropdownitems,
      onChanged: (currencyname){
        setState(() {
          selectedcurrency = currencyname;

        });
      },
    );

  } // android dropdown list
  CupertinoPicker iospicker(){
    List<Text> dropdownitems = [];
    for(String currency in currenciesList){
      dropdownitems.add(Text(currency));
    }
    return CupertinoPicker(
      itemExtent: 32,
      onSelectedItemChanged: (currentindex){
        print(currentindex);
      },
      children: dropdownitems,
    );

  } // ios picker

  @override
  Widget build(BuildContext context) {
    btcdata();
    ethdata();
    ltcdata();
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          bluerectangles(
            text: Text(
                '1 BTC = ${valuebtc.round()} $selectedcurrency', //${value.round()}
              style: bluerectanglesstyle,
            ),
          ),
          bluerectangles(
            text: Text(
              '1 ETH = ${valueeth.round()} $selectedcurrency', //${value.round()}
              style: bluerectanglesstyle,
            ),
          ),
          bluerectangles(
            text: Text(
              '1 LTC = ${valueltc.round()} $selectedcurrency', //${value.round()}
              style: bluerectanglesstyle,
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iospicker() : androiddropdownbutton(),
          ),
        ],
      ),
    );
  }
}
class bluerectangles extends StatelessWidget {
  bluerectangles({this.selectedcurrency, @required this.text});

  final String selectedcurrency;
  final Text text;

  @override
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
            child: text
        ),

      ),
    );
  }
}

//