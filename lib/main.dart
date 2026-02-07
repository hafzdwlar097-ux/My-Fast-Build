import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'إمبراطورية التجارة الذكية',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF2F2F2F),
      ),
      home: const OnboardingScreen(),
    );
  }
}

// شاشة الترحيب
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        children: [
          Container(
            color: const Color(0xFF2F2F2F),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'مرحباً بك في إمبراطورية التجارة الذكية',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'تطبيقنا يقدم لك أفضل المنتجات بأسعار منافسة',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: const Color(0xFF2F2F2F),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'استمتع بتجربة تسوق فريدة وممتعة',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'مع مجموعة واسعة من المنتجات التي تتناسب مع احتياجاتك',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: const Color(0xFF2F2F2F),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'انضم إلينا الآن واكتشف عالم من التسوق',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFFffd700),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'تسجيل الدخول',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _currentPage == 0
              ? const DotIndicator(true)
              : const DotIndicator(false),
          _currentPage == 1
              ? const DotIndicator(true)
              : const DotIndicator(false),
          _currentPage == 2
              ? const DotIndicator(true)
              : const DotIndicator(false),
        ],
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  final bool isActive;

  const DotIndicator(this.isActive, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFffd700) : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}

// شاشة تسجيل الدخول
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF2F2F2F),
              Color(0xFF2F2F2F),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'تسجيل الدخول',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
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
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFFffd700),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DashboardScreen(),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'تسجيل الدخول',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// شاشة الرئيسية
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'إمبراطورية التجارة الذكية',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF2F2F2F),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(
            product: products[index],
          );
        },
      ),
    );
  }
}

// كروت المنتجات
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF2F2F2F),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset(
              product.image,
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 10),
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${product.price} \$',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFFffd700),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailsScreen(
                      product: product,
                    ),
                  ),
                );
              },
              child: const Text(
                'إضافة للسلة',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// شاشة تفاصيل المنتج
class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.name,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF2F2F2F),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Image.asset(
              product.image,
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '${product.price} \$',
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              product.description,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// بيانات المنتجات
class Product {
  final String name;
  final String image;
  final double price;
  final String description;

  const Product({
    required this.name,
    required this.image,
    required this.price,
    required this.description,
  });
}

List<Product> products = [
  const Product(
    name: 'منتج 1',
    image: 'assets/image1.png',
    price: 10.99,
    description: 'وصف منتج 1',
  ),
  const Product(
    name: 'منتج 2',
    image: 'assets/image2.png',
    price: 20.99,
    description: 'وصف منتج 2',
  ),
  const Product(
    name: 'منتج 3',
    image: 'assets/image3.png',
    price: 30.99,
    description: 'وصف منتج 3',
  ),
  const Product(
    name: 'منتج 4',
    image: 'assets/image4.png',
    price: 40.99,
    description: 'وصف منتج 4',
  ),
  const Product(
    name: 'منتج 5',
    image: 'assets/image5.png',
    price: 50.99,
    description: 'وصف منتج 5',
  ),
  const Product(
    name: 'منتج 6',
    image: 'assets/image6.png',
    price: 60.99,
    description: 'وصف منتج 6',
  ),
  const Product(
    name: 'منتج 7',
    image: 'assets/image7.png',
    price: 70.99,
    description: 'وصف منتج 7',
  ),
  const Product(
    name: 'منتج 8',
    image: 'assets/image8.png',
    price: 80.99,
    description: 'وصف منتج 8',
  ),
  const Product(
    name: 'منتج 9',
    image: 'assets/image9.png',
    price: 90.99,
    description: 'وصف منتج 9',
  ),
  const Product(
    name: 'منتج 10',
    image: 'assets/image10.png',
    price: 100.99,
    description: 'وصف منتج 10',
  ),
  const Product(
    name: 'منتج 11',
    image: 'assets/image11.png',
    price: 110.99,
    description: 'وصف منتج 11',
  ),
  const Product(
    name: 'منتج 12',
    image: 'assets/image12.png',
    price: 120.99,
    description: 'وصف منتج 12',
  ),
  const Product(
    name: 'منتج 13',
    image: 'assets/image13.png',
    price: 130.99,
    description: 'وصف منتج 13',
  ),
  const Product(
    name: 'منتج 14',
    image: 'assets/image14.png',
    price: 140.99,
    description: 'وصف منتج 14',
  ),
  const Product(
    name: 'منتج 15',
    image: 'assets/image15.png',
    price: 150.99,
    description: 'وصف منتج 15',
  ),
  const Product(
    name: 'منتج 16',
    image: 'assets/image16.png',
    price: 160.99,
    description: 'وصف منتج 16',
  ),
  const Product(
    name: 'منتج 17',
    image: 'assets/image17.png',
    price: 170.99,
    description: 'وصف منتج 17',
  ),
  const Product(
    name: 'منتج 18',
    image: 'assets/image18.png',
    price: 180.99,
    description: 'وصف منتج 18',
  ),
  const Product(
    name: 'منتج 19',
    image: 'assets/image19.png',
    price: 190.99,
    description: 'وصف منتج 19',
  ),
  const Product(
    name: 'منتج 20',
    image: 'assets/image20.png',
    price: 200.99,
    description: 'وصف منتج 20',
  ),
  const Product(
    name: 'منتج 21',
    image: 'assets/image21.png',
    price: 210.99,
    description: 'وصف منتج 21',
  ),
  const Product(
    name: 'منتج 22',
    image: 'assets/image22.png',
    price: 220.99,
    description: 'وصف منتج 22',
  ),
  const Product(
    name: 'منتج 23',
    image: 'assets/image23.png',
    price: 230.99,
    description: 'وصف منتج 23',
  ),
  const Product(
    name: 'منتج 24',
    image: 'assets/image24.png',
    price: 240.99,
    description: 'وصف منتج 24',
  ),
  const Product(
    name: 'منتج 25',
    image: 'assets/image25.png',
    price: 250.99,
    description: 'وصف منتج 25',
  ),
  const Product(
    name: 'منتج 26',
    image: 'assets/image26.png',
    price: 260.99,
    description: 'وصف منتج 26',
  ),
  const Product(
    name: 'منتج 27',
    image: 'assets/image27.png',
    price: 270.99,
    description: 'وصف منتج 27',
  ),
  const Product(
    name: 'منتج 28',
    image: 'assets/image28.png',
    price: 280.99,
    description: 'وصف منتج 28',
  ),
  const Product(
    name: 'منتج 29',
    image: 'assets/image29.png',
    price: 290.99,
    description: 'وصف منتج 29',
  ),
  const Product(
    name: 'منتج 30',
    image: 'assets/image30.png',
    price: 300.99,
    description: 'وصف منتج 30',
  ),
  const Product(
    name: 'منتج 31',
    image: 'assets/image31.png',
    price: 310.99,
    description: 'وصف منتج 31',
  ),
  const Product(
    name: 'منتج 32',
    image: 'assets/image32.png',
    price: 320.99,
    description: 'وصف منتج 32',
  ),
  const Product(
    name: 'منتج 33',
    image: 'assets/image33.png',
    price: 330.99,
    description: 'وصف منتج 33',
  ),
  const Product(
    name: 'منتج 34',
    image: 'assets/image34.png',
    price: 340.99,
    description: 'وصف منتج 34',
  ),
  const Product(
    name: 'منتج 35',
    image: 'assets/image35.png',
    price: 350.99,
    description: 'وصف منتج 35',
  ),
  const Product(
    name: 'منتج 36',
    image: 'assets/image36.png',
    price: 360.99,
    description: 'وصف منتج 36',
  ),
  const Product(
    name: 'منتج 37',
    image: 'assets/image37.png',
    price: 370.99,
    description: 'وصف منتج 37',
  ),
  const Product(
    name: 'منتج 38',
    image: 'assets/image38.png',
    price: 380.99,
    description: 'وصف منتج 38',
  ),
  const Product(
    name: 'منتج 39',
    image: 'assets/image39.png',
    price: 390.99,
    description: 'وصف منتج 39',
  ),
  const Product(
    name: 'منتج 40',
    image: 'assets/image40.png',
    price: 400.99,
    description: 'وصف منتج 40',
  ),
  const Product(
    name: 'منتج 41',
    image: 'assets/image41.png',
    price: 410.99,
    description: 'وصف منتج 41',
  ),
  const Product(
    name: 'منتج 42',
    image: 'assets/image42.png