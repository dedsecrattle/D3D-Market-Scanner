import 'dart:convert';
import 'package:d3d_market_scanner_app/side-menu/side_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:http/http.dart' as http;

class SummaryPage extends StatefulWidget {
  const SummaryPage({Key? key}) : super(key: key);

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  var data = {};
  var technicalData = {};
  bool isLoadingData = true;
  bool isLoadingTechnical = true;

  @override
  void initState() {
    super.initState();
    updateSummary();
    updateTechnical();
  }

  Future updateSummary() async {
    const url = 'https://d3d-financial-data-api.onrender.com/init';
    final response = await http.get(Uri.parse(url));
    setState(() {
      data = jsonDecode(response.body);
      isLoadingData = false;
    });
  }

  Future updateTechnical() async {
    const url = 'https://d3d-financial-data-api.onrender.com/technical';
    final response = await http.get(Uri.parse(url));
    setState(() {
      technicalData = jsonDecode(response.body);
      isLoadingTechnical = false;
    });
  }

  Widget buildWidget(String? selectedOption) {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'Factor',
            style: TextStyle(fontSize: 20),
          ),
        ),
        DataColumn(
          label: Text(
            'Score',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
      rows: <DataRow>[
        buildRow("Interest Rate", data[selectedOption][0].toString()),
        buildRow("GDP Growth", data[selectedOption][1].toString()),
        buildRow("Inflation Rate", data[selectedOption][2].toString()),
        buildRow("Unemployment Rate", data[selectedOption][3].toString()),
        buildRow("COT Report", data[selectedOption][4].toString()),
        buildRow("Retail Sentiment", data[selectedOption][5].toString()),
        buildRow("Technicals", data[selectedOption][6].toString()),
        buildRow("Seasonality", data[selectedOption][7].toString()),
        buildRow("Total", data[selectedOption][8].toString()),
      ],
    );
  }

  DataRow buildRow(String factor, String score) {
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(factor)),
        DataCell(Text(score)),
      ],
    );
  }

  String? selectedOption = "EURUSD";
  Widget? displayedWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Market Summary'),
        backgroundColor: Colors.pink,
        leading: const SideMenuWidget(),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return isLoadingData || isLoadingTechnical
              ? Center(
                  child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                    ),
                    const CircularProgressIndicator(),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                        "Please Hold on for a moment , as we are using Free Servers for the Deployment it can take upto 1 Minute to fetch the Data from the Back-end")
                  ],
                ))
              : SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          DropdownButton<String>(
                            itemHeight: 75,
                            isExpanded: true,
                            focusColor: Colors.grey,
                            iconSize: 25,
                            value: selectedOption,
                            onChanged: (newValue) {
                              setState(() {
                                selectedOption = newValue;
                                displayedWidget = buildWidget(newValue);
                              });
                            },
                            items: <String>[
                              'EURUSD',
                              'USDJPY',
                              'GBPUSD',
                              'USDCHF',
                              'AUDUSD',
                              'NZDUSD',
                              'USDCAD'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 15),
                          displayedWidget ?? buildWidget("EURUSD"),
                          const SizedBox(height: 15),
                          const Center(
                            child: Text(
                              "D3D Technical Indicator",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          CircularPercentIndicator(
                            radius: 75,
                            animation: true,
                            backgroundColor: Colors.green,
                            progressColor: Colors.red,
                            percent: technicalData[selectedOption]["SELL"] >=
                                    technicalData[selectedOption]["BUY"]
                                ? getPercentage()
                                : 1 - getPercentage(),
                            lineWidth: 25,
                            center: Text(
                              "${(getPercentage() * 100).round().toString()}%",
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          const SizedBox(height: 15),
                          ExpansionTile(
                            title: const Text(
                                "How to Interpret the Scores and D3D Technical Indicator?"),
                            children: [
                              Container(
                                color: Colors.black12,
                                padding: const EdgeInsets.all(20),
                                width: double.infinity,
                                child: const Text(
                                  "The score is based on a scale of -100 to 100 where -ve score means a potential Sell/Short Trade and +ve score means a potential Buy/Long Trade and for the D3D Technical Indicator, Red Color means the potential Sell Oppurtunity and Green Color means potential Buy Oppurtunity , the Percentage in the Center is the Maximum of BUY/SELL Probability",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }

  double getPercentage() {
    int buy = technicalData[selectedOption]["BUY"];
    int sell = technicalData[selectedOption]["SELL"];
    int total = buy + sell;
    if (sell >= buy) {
      return double.parse((sell / total).toStringAsFixed(2));
    } else {
      return double.parse((buy / total).toStringAsFixed(2));
    }
  }
}
