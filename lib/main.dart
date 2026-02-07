import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
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
    setState(() {
      _counter++;
    });
    Vibration.vibrate();
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 15,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.refresh, color: Colors.white),
                    onPressed: _resetCounter,
                  ),
                ),
              ),
            ),
            Text(
              '$_counter',
              style: const TextStyle(fontSize: 48, color: Colors.white),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF800080), // أرجواني
                shape: const CircleBorder(),
                minimumSize: const Size(100, 100),
              ),
              onPressed: _incrementCounter,
              child: const Text(
                'سبّح',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}