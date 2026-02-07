// Build_ID_vsw0_1770480644
import 'package:flutter/material.dart';

void main() {
  runApp(const ScienceScannerApp());
}

class ScienceScannerApp extends StatelessWidget {
  const ScienceScannerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Science Scanner',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue[900]!,
          brightness: Brightness.light,
        ),
      ),
      home: const ScienceScannerHomePage(),
    );
  }
}

class ScienceScannerHomePage extends StatefulWidget {
  const ScienceScannerHomePage({Key? key}) : super(key: key);

  @override
  State<ScienceScannerHomePage> createState() => _ScienceScannerHomePageState();
}

class _ScienceScannerHomePageState extends State<ScienceScannerHomePage> {
  int _currentIndex = 0;

  final _pages = [
    const PhysicsCalculatorPage(),
    const ChemicalElementsDatabasePage(),
    const GeometryUnitsConverterPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'حاسبة قوانين الفيزياء',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'قاعدة بيانات العناصر الكيميائية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.compare),
            label: 'محول وحدات هندسية',
          ),
        ],
      ),
    );
  }
}

class PhysicsCalculatorPage extends StatefulWidget {
  const PhysicsCalculatorPage({Key? key}) : super(key: key);

  @override
  State<PhysicsCalculatorPage> createState() => _PhysicsCalculatorPageState();
}

class _PhysicsCalculatorPageState extends State<PhysicsCalculatorPage> {
  final _formKey = GlobalKey<FormState>();
  final _velocityController = TextEditingController();
  final _timeController = TextEditingController();
  final _accelerationController = TextEditingController();

  String _result = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _velocityController,
              decoration: const InputDecoration(
                labelText: 'السرعة',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'الرجاء إدخال قيمة';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _timeController,
              decoration: const InputDecoration(
                labelText: 'الوقت',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'الرجاء إدخال قيمة';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _accelerationController,
              decoration: const InputDecoration(
                labelText: 'التسارع',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'الرجاء إدخال قيمة';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final velocity = double.parse(_velocityController.text);
                  final time = double.parse(_timeController.text);
                  final acceleration = double.parse(_accelerationController.text);

                  final result = velocity * time + 0.5 * acceleration * time * time;

                  setState(() {
                    _result = result.toString();
                  });
                }
              },
              child: const Text('حس_ab'),
            ),
            Text(_result),
          ],
        ),
      ),
    );
  }
}

class ChemicalElementsDatabasePage extends StatefulWidget {
  const ChemicalElementsDatabasePage({Key? key}) : super(key: key);

  @override
  State<ChemicalElementsDatabasePage> createState() => _ChemicalElementsDatabasePageState();
}

class _ChemicalElementsDatabasePageState extends State<ChemicalElementsDatabasePage> {
  final _elements = [
    {'name': 'الهيدروجين', 'symbol': 'H', 'atomicNumber': 1},
    {'name': 'الهليوم', 'symbol': 'He', 'atomicNumber': 2},
    // أضف عناصر كيميائية هنا
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _elements.length,
      itemBuilder: (context, index) {
        final element = _elements[index];

        return ListTile(
          title: Text(element['name']!),
          subtitle: Text('${element['symbol']} - ${element['atomicNumber']}'),
        );
      },
    );
  }
}

class GeometryUnitsConverterPage extends StatefulWidget {
  const GeometryUnitsConverterPage({Key? key}) : super(key: key);

  @override
  State<GeometryUnitsConverterPage> createState() => _GeometryUnitsConverterPageState();
}

class _GeometryUnitsConverterPageState extends State<GeometryUnitsConverterPage> {
  final _fromController = TextEditingController();
  final _toController = TextEditingController();

  String _result = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextField(
            controller: _fromController,
            decoration: const InputDecoration(
              labelText: 'من',
            ),
          ),
          TextField(
            controller: _toController,
            decoration: const InputDecoration(
              labelText: 'إلى',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_fromController.text.isNotEmpty && _toController.text.isNotEmpty) {
                final from = double.parse(_fromController.text);
                final to = _toController.text;

                double result;

                if (to == 'مليمتر') {
                  result = from * 1000;
                } else if (to == 'سنتيمتر') {
                  result = from * 100;
                } else if (to == 'متر') {
                  result = from;
                } else {
                  result = 0;
                }

                setState(() {
                  _result = result.toString();
                });
              }
            },
            child: const Text('转换'),
          ),
          Text(_result),
        ],
      ),
    );
  }
}