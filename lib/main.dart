
import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MaterialApp(home: ColorFlashlight()));

class ColorFlashlight extends StatefulWidget {
  @override
  _ColorFlashlightState createState() => _ColorFlashlightState();
}

class _ColorFlashlightState extends State<ColorFlashlight> {
  Color _bgColor = Colors.white;
  String _colorName = "White";

  void _changeColor() {
    setState(() {
      _bgColor = Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
      _colorName = "Color: #${_bgColor.value.toRadixString(16).toUpperCase().substring(2)}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      body: GestureDetector(
        onTap: _changeColor,
        onLongPress: () => setState(() { _bgColor = Colors.white; _colorName = "White"; }),
        child: Center(
          child: Text(
            _colorName,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black54),
          ),
        ),
      ),
    );
  }
}
