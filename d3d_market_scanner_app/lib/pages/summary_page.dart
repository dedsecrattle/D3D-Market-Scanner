import 'package:d3d_market_scanner_app/side-menu/side_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({Key? key}) : super(key: key);

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
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
        buildRow("Interest Rate", "0"),
        buildRow("GBP Growth", "0"),
        buildRow("Inflation Rate", "0"),
        buildRow("Unemployment Rate", "0"),
        buildRow("COT Report", "0"),
        buildRow("Retail Sentiment", "0"),
        buildRow("Technicals", "0"),
        buildRow("Seasonality", "0"),
        buildRow("Total", "0"),
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
          return SingleChildScrollView(
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
                    CircularPercentIndicator(
                      radius: 75,
                      animation: true,
                      backgroundColor: Colors.green,
                      progressColor: Colors.red,
                      percent: 0.5,
                      lineWidth: 25,
                      center: const Text(
                        '50%',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
