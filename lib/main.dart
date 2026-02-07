import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'موسوعة الفضاء الشاملة',
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF6c5ce7),
        scaffoldBackgroundColor: const Color(0xFF2f2f2f),
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationController.forward();
    Future.delayed(const Duration(milliseconds: 2500), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Image.asset(
            'assets/space.png',
            width: 100,
            height: 100,
          ),
        ),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('موسوعة الفضاء الشاملة'),
      ),
      body: ListView(
        children: [
          Card(
            color: const Color(0xFF4c3f9d),
            child: ListTile(
              title: const Text('المريخ'),
              subtitle: const Text('المريخ هو الكوكب الرابع في النظام الشمسي'),
            ),
          ),
          Card(
            color: const Color(0xFF4c3f9d),
            child: ListTile(
              title: const Text('الزهرة'),
              subtitle: const Text('الزهرة هو الكوكب الثاني في النظام الشمسي'),
            ),
          ),
          Card(
            color: const Color(0xFF4c3f9d),
            child: ListTile(
              title: const Text('الأرض'),
              subtitle: const Text('الأرض هو الكوكب الثالث في النظام الشمسي'),
            ),
          ),
          Card(
            color: const Color(0xFF4c3f9d),
            child: ListTile(
              title: const Text('المشتري'),
              subtitle: const Text('المشتري هو الكوكب الخامس في النظام الشمسي'),
            ),
          ),
          Card(
            color: const Color(0xFF4c3f9d),
            child: ListTile(
              title: const Text('زحل'),
              subtitle: const Text('زحل هو الكوكب السادس في النظام الشمسي'),
            ),
          ),
          Card(
            color: const Color(0xFF4c3f9d),
            child: ListTile(
              title: const Text('أورانوس'),
              subtitle: const Text('أورانوس هو الكوكب السابع في النظام الشمسي'),
            ),
          ),
          Card(
            color: const Color(0xFF4c3f9d),
            child: ListTile(
              title: const Text('نبتون'),
              subtitle: const Text('نبتون هو الكوكب الثامن في النظام الشمسي'),
            ),
          ),
          Card(
            color: const Color(0xFF4c3f9d),
            child: ListTile(
              title: const Text('قمر'),
              subtitle: const Text('القمر هو الكوكب القمري للأرض'),
            ),
          ),
          Card(
            color: const Color(0xFF4c3f9d),
            child: ListTile(
              title: const Text('الشمس'),
              subtitle: const Text('الشمس هو نجم النظام الشمسي'),
            ),
          ),
          Card(
            color: const Color(0xFF4c3f9d),
            child: ListTile(
              title: const Text('النجوم'),
              subtitle: const Text('النجوم هي النجوم في النظام الشمسي'),
            ),
          ),
        ],
      ),
    );
  }
}

class PlanetPage extends StatelessWidget {
  final String title;
  final String description;

  const PlanetPage({Key? key, required this.title, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          description,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class StarList extends StatefulWidget {
  const StarList({Key? key}) : super(key: key);

  @override
  State<StarList> createState() => _StarListState();
}

class _StarListState extends State<StarList> {
  final List<String> _stars = [
    'الشمس',
    'النجوم',
    'المريخ',
    'الزهرة',
    'الأرض',
    'المشتري',
    'زحل',
    'أورانوس',
    'نبتون',
    'القمر',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('النجوم'),
      ),
      body: ListView.builder(
        itemCount: _stars.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_stars[index]),
          );
        },
      ),
    );
  }
}

class CustomTransition extends PageRouteBuilder {
  final Widget page;

  CustomTransition(this.page)
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return ScaleTransition(
              scale: animation,
              child: child,
            );
          },
        );
}