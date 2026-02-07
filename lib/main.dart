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
  Color _backgroundColor = Colors.white;
  Color _colorName = Colors.black;
  String _colorText = 'WHITE';
  bool _showResetIcon = false;

  void _changeBackgroundColor() {
    setState(() {
      _backgroundColor = Color.fromRGBO(
        _randomNumber(255),
        _randomNumber(255),
        _randomNumber(255),
        1,
      );
      _colorName = _getTextColor(_backgroundColor);
      _colorText = _getEnglishColorName(_backgroundColor);
    });
  }

  void _showResetIconOnLongPress() {
    setState(() {
      _showResetIcon = true;
    });
  }

  void _resetBackgroundColor() {
    setState(() {
      _backgroundColor = Colors.white;
      _colorName = Colors.black;
      _colorText = 'WHITE';
      _showResetIcon = false;
    });
  }

  int _randomNumber(int max) {
    return Random().nextInt(max);
  }

  Color _getTextColor(Color backgroundColor) {
    return ThemeData.estimateBrightnessForColor(backgroundColor) == Brightness.light
        ? Colors.black
        : Colors.white;
  }

  String _getEnglishColorName(Color color) {
    if (color == Colors.white) return 'WHITE';
    if (color == Colors.black) return 'BLACK';
    if (color == Colors.red) return 'RED';
    if (color == Colors.green) return 'GREEN';
    if (color == Colors.blue) return 'BLUE';
    if (color == Colors.yellow) return 'YELLOW';
    if (color == Colors.purple) return 'PURPLE';
    if (color == Colors.orange) return 'ORANGE';
    if (color == Colors.pink) return 'PINK';
    if (color == Colors.brown) return 'BROWN';
    if (color == Colors.grey) return 'GREY';
    return 'CUSTOM';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _changeBackgroundColor,
      onLongPress: _showResetIconOnLongPress,
      child: Container(
        color: _backgroundColor,
        child: Stack(
          children: [
            Center(
              child: Text(
                _colorText,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: _colorName,
                ),
              ),
            ),
            if (_showResetIcon)
              Positioned(
                top: 20,
                right: 20,
                child: IconButton(
                  icon: const Icon(
                    Icons.reset_tv,
                    color: Colors.white,
                  ),
                  onPressed: _resetBackgroundColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}