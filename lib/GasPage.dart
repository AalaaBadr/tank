import 'package:flutter/material.dart';

class GasPage extends StatefulWidget {
  const GasPage({Key? key}) : super(key: key);

  @override
  State<GasPage> createState() => _GasPageState();
}

class _GasPageState extends State<GasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          "Gas Page",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.red,
            Colors.white,
          ],
        )),
      ),
    );
  }
}
