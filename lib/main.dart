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
  String _hour = '';
  String _minute = '';
  String _second = '';
  String _date = '';

  @override
  void initState() {
    super.initState();
    _updateTime();
  }

  void _updateTime() {
    setState(() {
      DateTime now = DateTime.now();
      _hour = now.hour.toString().padLeft(2, '0');
      _minute = now.minute.toString().padLeft(2, '0');
      _second = now.second.toString().padLeft(2, '0');
      _date = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    });
    Future.delayed(const Duration(seconds: 1), _updateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PulseAnimation(
                    child: Text(
                      _hour,
                      style: const TextStyle(fontSize: 64, color: Colors.greenAccent, fontFamily: 'Digital7'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(':', style: TextStyle(fontSize: 64, color: Colors.greenAccent)),
                  const SizedBox(width: 10),
                  PulseAnimation(
                    child: Text(
                      _minute,
                      style: const TextStyle(fontSize: 64, color: Colors.greenAccent, fontFamily: 'Digital7'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(':', style: TextStyle(fontSize: 64, color: Colors.greenAccent)),
                  const SizedBox(width: 10),
                  PulseAnimation(
                    child: Text(
                      _second,
                      style: const TextStyle(fontSize: 64, color: Colors.greenAccent, fontFamily: 'Digital7'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(_date, style: const TextStyle(fontSize: 24, color: Colors.greenAccent)),
            ],
          ),
        ),
      ),
    );
  }
}

class PulseAnimation extends StatefulWidget {
  final Widget child;

  const PulseAnimation({Key? key, required this.child}) : super(key: key);

  @override
  State<PulseAnimation> createState() => _PulseAnimationState();
}

class _PulseAnimationState extends State<PulseAnimation> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(_animationController);
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }
}