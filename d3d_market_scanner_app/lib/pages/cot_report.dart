import 'package:d3d_market_scanner_app/side-menu/side_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CotReport extends StatefulWidget {
  const CotReport({super.key});

  @override
  State<CotReport> createState() => _CotReportState();
}

class _CotReportState extends State<CotReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("COT Report"),
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
                  buildReport(50, "EUR"),
                  buildReport(70, "GBP"),
                  buildReport(90, "JPY"),
                  buildReport(10, "USD"),
                  buildReport(40, "CHF"),
                  buildReport(50, "CAD"),
                  buildReport(80, "NZD"),
                  const SizedBox(height: 40),
                  ExpansionTile(
                    title: const Text("What is COT Report?"),
                    children: [
                      Container(
                        color: Colors.black12,
                        padding: const EdgeInsets.all(20),
                        width: double.infinity,
                        child: const Text(
                          "The COT report shows how committed the large institutional “non-commercial” traders are to long or short positions within each currency pair. If traders are net short, the COT graph will show a negative position and if they are net long the COT graph will show a positive position.",
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
        width: MediaQuery.of(context).size.width - 100,
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
