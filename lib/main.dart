يُرجى ملاحظة أن هذا الإجابة سوف تصنع تطبيق Flutter بسيط، إذا كنت تريد أكثر تعقيداً يجب عليك تقديم مزيد من التفاصيل.

أيضاً يجب أن يكون لديك الحزمة shared_preferences مثبتة في مشروعك.

إليك كيفية تنفيذ التطبيق:

**ملف `pubspec.yaml`**

name: store_app
description: A new Flutter project.

version: 1.0.0+1

environment:
  sdk: ">=2.17.1 <3.0.0"

dependencies:
  flutter:
    sdk: flutter

  shared_preferences: ^2.1.1

dev_dependencies:
  flutter_test:
    sdk: flutter

  flutter_lints: ^2.0.0

**ملف `main.dart`**

import 'package:flutter/material.dart';
import 'package:store_app/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn');
  runApp(
    MaterialApp(
      title: 'متجر इलكتروني',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isLoggedIn == true ? const HomeScreen() : const LoginScreen(),
    ),
  );
}

**ملف `login_screen.dart`**

import 'package:flutter/material.dart';
import 'package:store_app/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تسجيل الدخول'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'البريد الإلكتروني',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'البريد الإلكتروني مطلوب';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'كلمة المرور',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'كلمة المرور مطلوبة';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('isLoggedIn', true);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  }
                },
                child: const Text('تسجيل الدخول'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

**ملف `home_screen.dart`**

import 'package:flutter/material.dart';
import 'package:store_app/screens/product_screen.dart';
import 'package:store_app/screens/cart_screen.dart';
import 'package:store_app/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final _screens = [
    const ProductScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'المنتجات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'سلة المشتريات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'البروفايل',
          ),
        ],
      ),
    );
  }
}

**ملف `product_screen.dart`**

import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المنتجات'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Image.network(
                    'https://via.placeholder.com/100',
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('المنتج 1'),
                      Text('السعر: 100'),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

**ملف `cart_screen.dart`**

import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سلة المشتريات'),
      ),
      body: const Center(
        child: Text('سلة المشتريات فارغة'),
      ),
    );
  }
}

**ملف `profile_screen.dart`**

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('البروفايل'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('isLoggedIn', false);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          },
          child: const Text('تسجيل الخروج'),
        ),
      ),
    );
  }
}

يمكنك تشغيل التطبيق باستخدام `flutter run`. 

ملاحظة: هذا التطبيق بسيط جدا ولا يتضمن جميع الميزات التي قد يتوقعها المستخدمون في تطبيق متجر إلكتروني. لإنشاء تطبيق متجر إلكتروني完整 يجب أن تكون على دراية جيدة بتقنيات Flask والتصميم العام للتطبيقات.