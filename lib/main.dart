import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TasbeehScreen(),
    );
  }
}

class TasbeehScreen extends StatefulWidget {
  const TasbeehScreen({Key? key}) : super(key: key);

  @override
  State<TasbeehScreen> createState() => _TasbeehScreenState();
}

class _TasbeehScreenState extends State<TasbeehScreen> {
  int _count = 0;

  void _incrementCounter() {
    setState(() {
      _count++;
      Vibration.vibrate(pattern: [100, 100, 100, 100]);
    });
  }

  void _resetCounter() {
    setState(() {
      _count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF000000),
                  padding: const EdgeInsets.all(8),
                  shape: const CircleBorder(),
                  minimumSize: const Size(40, 40),
                ),
                onPressed: _resetCounter,
                child: const Icon(
                  Icons.restart_alt,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                '$_count',
                style: const TextStyle(fontSize: 64, color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF7A288A),
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