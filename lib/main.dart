// Build ID: ifeej_1770479511
class FastBridgeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FastBridge',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: FastBridgeHomePage(),
    );
  }
}

class FastBridgeHomePage extends StatefulWidget {
  @override
  _FastBridgeHomePageState createState() => _FastBridgeHomePageState();
}

class _FastBridgeHomePageState extends State<FastBridgeHomePage> {
  final _filePicker = FilePicker.platform;
  final _httpServer = HttpServer();
  final _ipAddress = '';
  final _transferSpeed = '';
  File? _selectedFile;

  Future<void> _sendFile() async {
    final file = await _filePicker.pickFile();
    if (file != null) {
      setState(() {
        _selectedFile = File(file.path);
      });
    }
  }

  Future<void> _receiveFile() async {
    final server = await _httpServer.bind(InternetAddress.anyIPv4, 8080);
    setState(() {
      _ipAddress = server.address.address;
    });
    server.listen((request) {
      request.response.headers.set('Content-Type', 'application/octet-stream');
      request.response.headers.set('Content-Disposition', 'attachment; filename=${_selectedFile?.path.split('/').last}');
      _selectedFile?.readAsBytes().then((bytes) {
        request.response.add(bytes);
        request.response.close();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FastBridge'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _sendFile,
              child: Text('ارسال'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _receiveFile,
              child: Text('استقبال'),
            ),
            SizedBox(height: 20),
            Text(_ipAddress.isEmpty ? 'لا يوجد عنوان IP' : 'العنوان IP: $_ipAddress'),
            SizedBox(height: 20),
            Text(_transferSpeed.isEmpty ? 'لا يوجد سرعة نقل' : 'سرعة النقل: $_transferSpeed'),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(FastBridgeApp());
}