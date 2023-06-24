import 'package:flutter/material.dart';

class VolatilityPage extends StatefulWidget {
  const VolatilityPage({super.key});

  @override
  State<VolatilityPage> createState() => _VolatilityPageState();
}

class _VolatilityPageState extends State<VolatilityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Volatility")),
      body: Container(),
    );
  }
}
