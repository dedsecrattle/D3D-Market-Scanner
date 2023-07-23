import 'package:d3d_market_scanner_app/side-menu/side_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_count_down.dart';

import 'main.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Home'),
        leading: const SideMenuWidget(),
      ),
      body: Column(children: [
        const SizedBox(
          height: 20,
        ),
        const Center(
          child: Text(
            "Forex Market Around World",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: DataTable(
              dataRowMinHeight: 25,
              columnSpacing: MediaQuery.of(context).size.width / 2.5,
              columns: const [
                DataColumn(
                    label: Text(
                  'Session',
                  style: TextStyle(fontSize: 18),
                )),
                DataColumn(
                    label: Text(
                  'Status',
                  style: TextStyle(fontSize: 18),
                )),
              ],
              rows: [
                DataRow(cells: [
                  const DataCell(Text(
                    'London',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  DataCell(getStatus('london')),
                ]),
                DataRow(cells: [
                  const DataCell(Text(
                    'Tokyo',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  DataCell(getStatus('tokyo')),
                ]),
                DataRow(cells: [
                  const DataCell(Text(
                    'New York',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  DataCell(getStatus('newyork')),
                ]),
                DataRow(cells: [
                  const DataCell(Text(
                    'Sydney',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  DataCell(getStatus('sydney')),
                ]),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        isLoading
            ? const Text(
                "Fetching Latest Data from the Market",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              )
            : const Text("App is Running with Latest Data from Market",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 16,
        ),
        isLoading
            ? Countdown(
                seconds: 30,
                build: (BuildContext context, double time) => Text(
                  time.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                interval: const Duration(milliseconds: 100),
                onFinished: () {
                  setState(() {
                    isLoading = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.pink,
                      content:
                          Text('Successfully Fetched Latest Data from Market'),
                    ),
                  );
                },
              )
            : Text(
                "Data Updated on ${DateTime.now().toString().substring(0, 16)}")
      ]),
    );
  }

  Text getMarketVolatility() {
    DateTime datenow = DateTime.now().toUtc();
    int hour = datenow.hour;
    if (hour >= 0 && hour <= 7) {
      return const Text('Low');
    } else if (hour > 7 && hour <= 18) {
      return const Text('HigH');
    } else {
      return const Text('Moderate');
    }
  }

  Text getStatus(String session) {
    DateTime datenow = DateTime.now().toUtc();
    int hour = datenow.hour;
    if (session == 'london') {
      if (hour >= 8 && hour < 16) {
        return const Text("Open",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green));
      } else {
        return const Text("Closed",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red));
      }
    } else if (session == "tokyo") {
      if (hour == 24 || (hour >= 1 && hour < 9)) {
        return const Text("Open",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green));
      } else {
        return const Text("Closed",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red));
      }
    } else if (session == 'newyork') {
      if (hour >= 13 && hour < 22) {
        return const Text("Open",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green));
      } else {
        return const Text("Closed",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red));
      }
    } else {
      if ((hour >= 20 && hour < 24) || (hour >= 1 && hour < 6)) {
        return const Text("Open",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green));
      } else {
        return const Text("Closed",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red));
      }
    }
  }
}
