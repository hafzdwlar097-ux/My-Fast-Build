```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ساعة رقمية',
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
  final DateTime _now = DateTime.now();
  int _hour = 0;
  int _minute = 0;
  int _second = 0;
  String _date = '';

  @override
  void initState() {
    super.initState();
    _updateTime();
  }

  void _updateTime() {
    final DateTime now = DateTime.now();
    setState(() {
      _hour = now.hour;
      _minute = now.minute;
      _second = now.second;
      _date = '${now.year}-${now.month}-${now.day}';
    });
    Future.delayed(const Duration(seconds: 1), _updateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: AlwaysStoppedAnimation(1),
              builder: (context, child) {
                final double scale = 1 + (DateTime.now().millisecond % 100) / 100;
                return Transform.scale(
                  scale: scale,
                  child: Text(
                    '${_hour.toString().padLeft(2, '0')}:${_minute.toString().padLeft(2, '0')}:${_second.toString().padLeft(2, '0')}',
                    style: const TextStyle(
                      fontSize: 120,
                      color: Color(0xFF33CC33), // Neon Green
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Text(
              _date,
              style: const TextStyle(
                fontSize: 30,
                color: Color(0xFF33CC33), // Neon Green
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```