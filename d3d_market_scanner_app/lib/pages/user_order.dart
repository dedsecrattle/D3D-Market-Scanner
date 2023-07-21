import 'dart:convert';

import 'package:d3d_market_scanner_app/pages/chart_page.dart';
import 'package:d3d_market_scanner_app/side-menu/side_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CurrencyPair {
  final String name;

  CurrencyPair(this.name);
}

class OrderStatusPage extends StatefulWidget {
  const OrderStatusPage({super.key});

  @override
  State<OrderStatusPage> createState() => _OrderStatusPageState();
}

class _OrderStatusPageState extends State<OrderStatusPage> {
  var data = {};
  String selectedPair = 'EUR/USD';
  String ordertype = 'Buy';
  TextEditingController lotSizeController = TextEditingController();
  TextEditingController entryPointController = TextEditingController();
  Widget orderDetails = const Text("Not Valid Values");
  bool showReport = true;

  final currencymap = {
    "EUR/USD": 0,
    "AUD/USD": 1,
    "USD/CHF": 2,
    "USD/JPY": 3,
    "GBP/USD": 4,
    "NZD/USD": 5
  };

  List<String> orderType = ["Buy", "Sell"];

  List<CurrencyPair> currencyPairs = [
    CurrencyPair('EUR/USD'),
    CurrencyPair('AUD/USD'),
    CurrencyPair('GBP/USD'),
    CurrencyPair('USD/JPY'),
    CurrencyPair('USD/CHF'),
    CurrencyPair('NZD/USD'),
  ];

  @override
  void initState() {
    super.initState();
    getPrice();
  }

  Future<void> getPrice() async {
    const url =
        'https://fcsapi.com/api-v3/forex/latest?symbol=EUR/USD,AUD/USD,GBP/USD,USD/JPY,USD/CHF,NZD/USD&access_key=jSdWVAwJQmKARsA1eyb8MgN';
    // Replace with the URL of your JSON API
    final response = await http.get(Uri.parse(url));
    setState(() {
      data = jsonDecode(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        leading: const SideMenuWidget(),
        title: const Text('Order Status'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("Currency Pair"),
            DropdownButton(
              value: selectedPair,
              onChanged: (String? newValue) {
                setState(() {
                  selectedPair = newValue ?? "EURUSD";
                  showReport = true;
                });
              },
              items: currencyPairs.map((CurrencyPair pair) {
                return DropdownMenuItem(
                    value: pair.name,
                    alignment: Alignment.center,
                    child: Text(pair.name));
              }).toList(),
            ),
            const SizedBox(height: 16),
            const Text("Order Type"),
            DropdownButton(
                value: ordertype,
                items: orderType.map((String type) {
                  return DropdownMenuItem(value: type, child: Text(type));
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    ordertype = newValue ?? 'Buy';
                  });
                }),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: lotSizeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Lot Size'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: entryPointController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Entry Point'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
              onPressed: () {
                String lotSize = lotSizeController.text;
                String entryPoint = entryPointController.text;
                String current =
                    data['response'][currencymap[selectedPair]]['c'];

                orderDetails = calculateForexProfitLoss(double.parse(lotSize),
                    double.parse(entryPoint), double.parse(current));

                setState(() {
                  showReport = false;
                });
              },
              child: const Text(
                'Get Status',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            showReport
                ? const Text(
                    "Press on Get Status to get Latest Status of your Order",
                    style: TextStyle(fontSize: 15),
                  )
                : data["response"] != null
                    ? Center(child: orderDetails)
                    : const Text(
                        "Server is Overloaded , Please try again Later"),
            const SizedBox(
              height: 26,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ChartPage()));
                },
                child: const Text("View Live Chart"))
          ],
        ),
      ),
    );
  }

  Widget calculateForexProfitLoss(
      double lotSize, double entryPoint, double currentMarketPrice) {
    double profitLoss = (currentMarketPrice - entryPoint) * lotSize * 100000;
    if (ordertype == "Buy") {
      return profitLoss >= 0
          ? Text(
              "Your Order is in Profit of USD ${profitLoss.round().abs().toString()}",
              style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            )
          : Text(
              "Your Order is in Loss of USD ${profitLoss.round().abs().toString()}",
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 15),
            );
    } else {
      return profitLoss < 0
          ? Text(
              "Your Order is in Profit of USD ${profitLoss.round().abs().toString()}",
              style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            )
          : Text(
              "Your Order is in Loss of USD ${profitLoss.round().abs().toString()}",
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 15),
            );
    }
  }
}
