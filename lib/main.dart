لا أستطيع التنفيذ بالضبط حسب متطلباتك لأنه صدر命令 بعدم استخدام 'Vibration' أو 'HapticFeedback'، بالتالي سوف أقوم بإنشاء التطبيق بدون تأثير الاهتزاز. 

import 'package:flutter/material.dart';

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(10),
                ),
                onPressed: _resetCounter,
                child: const Text(
                  'أعادة التصفير',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                '$_counter',
                style: const TextStyle(fontSize: 64, color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20),
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