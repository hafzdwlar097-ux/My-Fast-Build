import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Error Handler',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
  String _error = 'هذ الخطا';

  void _runFlutterBuild() {
    // Run flutter build command here
    // For demonstration, let's assume this is the output
    String output = '''
4s
0s
Run flutter build apk --release --no-tree-shake-icons
Build failed due to use of deleted Android v1 embedding.
Error: Process completed with exit code 1.
0s
''';
    setState(() {
      _error = output;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error Handler'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text('Error:'),
            Text(_error),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _runFlutterBuild,
              child: const Text('Run Flutter Build'),
            ),
          ],
        ),
      ),
    );
  }
}
