import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'سبحة إلكترونية',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    HapticFeedback.lightImpact();
    setState(() {
      _counter++;
    });
  }

  void _resetCounter() {
    HapticFeedback.lightImpact();
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                  shape: const CircleBorder(),
                  minimumSize: const Size(40, 40),
                ),
                onPressed: _resetCounter,
                child: const Text('ريست'),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                '$_counter',
                style: const TextStyle(
                  fontSize: 64,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.purple,
                shape: const CircleBorder(),
                minimumSize: const Size(120, 120),
              ),
              onPressed: _incrementCounter,
              child: const Text(
                'سبّح',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}