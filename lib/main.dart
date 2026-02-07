import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _StoredText = '';

  Future<void> _storeText() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('storedText', 'Hello, World!');
  }

  Future<void> _readText() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _StoredText = prefs.getString('storedText') ?? '';
    });
  }

  Future<void> _removeText() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('storedText');
    setState(() {
      _StoredText = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setup'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _storeText,
              child: const Text('Store Text'),
            ),
            ElevatedButton(
              onPressed: _readText,
              child: const Text('Read Text'),
            ),
            ElevatedButton(
              onPressed: _removeText,
              child: const Text('Remove Text'),
            ),
            Text(_StoredText),
          ],
        ),
      ),
    );
  }
}