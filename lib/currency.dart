import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CurrencyPage extends StatelessWidget {
  const CurrencyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('CURRENCY EXCHANGE'),
          backgroundColor: Color.fromARGB(255, 15, 58, 94),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              height: 150,
              child: Center(
                child:
                    Image.asset('assets/images/currencycalc.png', scale: 2.0),
              ),
            ),
            Container(child: CurrencyForm()),
          ]),
        ),
      ),
    );
  }
}

class CurrencyForm extends StatefulWidget {
  const CurrencyForm({Key? key}) : super(key: key);

  @override
  State<CurrencyForm> createState() => _CurrencyFormState();
}

class _CurrencyFormState extends State<CurrencyForm> {
  TextEditingController rateEditingController = TextEditingController();
  String selectCurrency = "myr";
  double rates = 0.0, convertResult = 0.0;
  List<String> ratesList = [
    "btc",
    "eth",
    "ltc",
    "bch",
    "bnb",
    "eos",
    "xrp",
    "xlm",
    "link",
    "dot",
    "yfi",
    "usd",
    "aed",
    "ars",
    "aud",
    "bdt",
    "cny",
    "czk",
    "bhd",
    "bmf",
    "brl",
    "cad",
    "chf",
    "clp",
    "dkk",
    "eur",
    "gbp",
    "hkd",
    "huf",
    "idr",
    "ils",
    "inr",
    "jpy",
    "krw",
    "kwd",
    "lkr",
    "mmk",
    "mxn",
    "myr",
    "ngn",
    "nok",
    "nzd",
    "php",
    "pkr",
    "pln",
    "rub",
    "sar",
    "sek",
    "sgd",
    "thb",
    "try",
    "twd",
    "uah",
    "vef",
    "vnd",
    "zar",
    "xdr",
    "xag",
    "bits",
    "sats",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "BitCoin Cryptocurrency",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: rateEditingController,
            keyboardType: const TextInputType.numberWithOptions(),
            decoration: InputDecoration(
                hintText: "insert value to convert",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0))),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: DropdownButton(
                  itemHeight: 100,
                  value: selectCurrency,
                  onChanged: (newValue) {
                    setState(() {
                      selectCurrency = newValue.toString();
                    });
                  },
                  items: ratesList.map((selectCurrency) {
                    return DropdownMenuItem(
                      child: Text(
                        selectCurrency,
                      ),
                      value: selectCurrency,
                    );
                  }).toList(),
                ),
              ),
              ElevatedButton(
                  onPressed: _loadCurrency, child: const Text("convert")),
              const SizedBox(height: 5),
            ],
          ),
          Text(
            "btc value in $selectCurrency is " +
                convertResult.toStringAsFixed(2),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
    );
  }

  Future<void> _loadCurrency() async {
    var url = Uri.parse('https://api.coingecko.com/api/v3/exchange_rates');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = response.body;
      var parsedData = json.decode(jsonData);
      rates = parsedData['rates'][selectCurrency]['value'];

      setState(() {
        convertResult = rates * double.parse(rateEditingController.text);
      });
    }
  }
}
