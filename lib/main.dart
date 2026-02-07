import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TasbeehScreen(),
    );
  }
}

class TasbeehScreen extends StatefulWidget {
  const TasbeehScreen({super.key});

  @override
  State<TasbeehScreen> createState() => _TasbeehScreenState();
}

class _TasbeehScreenState extends State<TasbeehScreen> {
  int _tasbeehCount = 0;

  void _resetCount() {
    setState(() {
      _tasbeehCount = 0;
    });
  }

  void _incrementCount() {
    Vibration.vibrate(pattern: [100]);
    setState(() {
      _tasbeehCount++;
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
                  backgroundColor: Colors.grey,
                  shape: const CircleBorder(),
                  minimumSize: const Size(40, 40),
                ),
                onPressed: _resetCount,
                child: const Icon(Icons.restart_alt),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                _tasbeehCount.toString(),
                style: const TextStyle(fontSize: 64, color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7A288A),
                shape: const CircleBorder(),
                minimumSize: const Size(100, 100),
              ),
              onPressed: _incrementCount,
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