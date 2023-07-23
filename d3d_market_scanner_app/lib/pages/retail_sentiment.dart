import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../side-menu/side_menu_widget.dart';
import 'package:http/http.dart' as http;

class RetailSentiments extends StatefulWidget {
  const RetailSentiments({super.key});

  @override
  State<RetailSentiments> createState() => _RetailSentimentsState();
}

class _RetailSentimentsState extends State<RetailSentiments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Retail Sentiment"),
        backgroundColor: Colors.pink,
        leading: const SideMenuWidget(),
      ),
      body: FutureBuilder(
          future: fetchRetail(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: constraints.maxWidth,
                        minHeight: constraints.maxHeight,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 25),
                          buildReport(
                              snapshot.data["EURUSD"]['long'], "EURUSD"),
                          buildReport(
                              snapshot.data["GBPUSD"]['long'], "GBPUSD"),
                          buildReport(
                              snapshot.data["USDJPY"]['long'], "USDJPY"),
                          buildReport(
                              snapshot.data["AUDUSD"]['long'], "AUDUSD"),
                          buildReport(
                              snapshot.data["USDCHF"]['long'], "USDCHF"),
                          buildReport(
                              snapshot.data["USDCAD"]['long'], "USDCAD"),
                          buildReport(
                              snapshot.data["NZDUSD"]['long'], "NZDUSD"),
                          const SizedBox(height: 40),
                          ExpansionTile(
                            title: const Text("What is Retail Sentiment?"),
                            children: [
                              Container(
                                color: Colors.black12,
                                padding: const EdgeInsets.all(20),
                                width: double.infinity,
                                child: const Text(
                                  "Retail sentiment is a measurement of long and short positions in a certain market by the retail crowd. A retail investor is any kind of investor that is not an institution, insider or entity other than an individual. Oftentimes, retail sentiment is inversely correlated to what big money is doing.",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Widget buildReport(int percentage, String currency) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: LinearPercentIndicator(
        width: MediaQuery.of(context).size.width - 125,
        animation: true,
        lineHeight: 20.0,
        animationDuration: 2000,
        percent: percentage / 100,
        center: Text("$percentage%"),
        leading: Text(currency),
        progressColor: Colors.green,
        backgroundColor: Colors.red,
        barRadius: const Radius.circular(10),
      ),
    );
  }

  Future<dynamic> fetchRetail() async {
    var response = await http
        .get(Uri.parse("https://d3d-financial-data-api.onrender.com/retail"));

    return jsonDecode(response.body);
  }
}
