import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'مسبحة إلكترونية',
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
  final HapticFeedback _hapticFeedback = HapticFeedback.heavy;

  void _incrementCounter() {
    _hapticFeedback.vibrate();
    setState(() {
      _count++;
    });
  }

  void _resetCounter() {
    _hapticFeedback.vibrate();
    setState(() {
      _count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.white,
                    shape: const CircleBorder(),
                    minimumSize: const Size(40, 40),
                  ),
                  onPressed: _resetCounter,
                  child: const Text('Reset'),
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            Text(
              '$_count',
              style: const TextStyle(fontSize: 64, color: Colors.white),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7A288A), // Purple
                foregroundColor: Colors.white,
                shape: const CircleBorder(),
                minimumSize: const Size(100, 100),
              ),
              onPressed: _incrementCounter,
              child: const Text('سبّح', style: TextStyle(fontSize: 24)),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}