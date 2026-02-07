```dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/server.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'FastBridge',
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
  final _ipController = TextEditingController();
  final _speedController = TextEditingController();
  late HttpServer _server;
  late String _selectedFile;
  late File file;

  @override
  void dispose() {
    _ipController.dispose();
    _speedController.dispose();
    if (_server != null) {
      _server.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FastBridge'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _sendFile,
              child: const Text('إرسال'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _receiveFile,
              child: const Text('استقبال'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _ipController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'عنوان الـ IP',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _speedController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'سرعة النقل',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _selectedFile = result.files.first.path ?? '';
      });
      file = File(_selectedFile);
      await _sendFileToServer(file);
    }
  }

  void _receiveFile() async {
    await HttpServer.bind(InternetAddress.anyIPv4, 8080).then((server) {
      _server = server;
      setState(() {
        _ipController.text = 'http://${_server.address.address}:${_server.port}';
      });
      server.listen((request) {
        if (request.method == 'POST') {
          request.listen((data) {
            final file = File('ReceivedFile');
            file.writeAsBytesSync(data);
            setState(() {
              _speedController.text = 'تم استلام الملف';
            });
          });
        }
      });
    });
  }

  Future _sendFileToServer(File file) async {
    final url = Uri.parse(_ipController.text);
    final request = http.MultipartRequest('POST', url);
    request.files.add(http.MultipartFile.fromBytes(
      'file',
      await file.readAsBytes(),
      filename: file.path.split('/').last,
    ));
    final response = await request.send();
    if (response.statusCode == 200) {
      setState(() {
        _speedController.text = 'تم إرسال الملف بنجاح';
      });
    }
  }
}
```