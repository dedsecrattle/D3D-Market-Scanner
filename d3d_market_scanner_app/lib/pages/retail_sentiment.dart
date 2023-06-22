import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../side-menu/side_menu_widget.dart';

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
      body: LayoutBuilder(
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
                  buildReport(50, "EURUSD"),
                  buildReport(70, "GBPUSD"),
                  buildReport(90, "USDJPY"),
                  buildReport(10, "AUDUSD"),
                  buildReport(40, "USDCHF"),
                  buildReport(50, "USDCAD"),
                  buildReport(80, "NZDUSD"),
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
      ),
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
}
