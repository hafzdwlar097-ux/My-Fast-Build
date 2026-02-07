import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:haptic_feedback/haptic_feedback.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Habit> habits = [];
  double consistencyMeter = 0.0;
  final _formKey = GlobalKey<FormState>();
  final _habitController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadHabits();
  }

  Future<void> _loadHabits() async {
    final prefs = await SharedPreferences.getInstance();
    final habitsJson = prefs.getString('habits');
    if (habitsJson != null) {
      final habitsList = jsonDecode(habitsJson) as List;
      setState(() {
        habits = habitsList.map((habit) => Habit.fromJson(habit)).toList();
        _updateConsistencyMeter();
      });
    }
  }

  Future<void> _saveHabits() async {
    final prefs = await SharedPreferences.getInstance();
    final habitsJson = jsonEncode(habits.map((habit) => habit.toJson()).toList());
    await prefs.setString('habits', habitsJson);
  }

  void _addHabit() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        habits.add(Habit(name: _habitController.text, completed: false));
        _updateConsistencyMeter();
      });
      _saveHabits();
      _habitController.clear();
    }
  }

  void _toggleHabit(Habit habit) {
    setState(() {
      habit.completed = !habit.completed;
      _updateConsistencyMeter();
    });
    _saveHabits();
    if (habits.every((h) => h.completed)) {
      HapticFeedback.vibrate();
      _showCelebratoryMessage();
    }
  }

  void _updateConsistencyMeter() {
    final completedHabits = habits.where((habit) => habit.completed).length;
    consistencyMeter = completedHabits / habits.length;
  }

  void _showCelebratoryMessage() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تحياتنا!'),
        content: const Text('لقد أكملت جميع العادات اليوم!"),
        actions: [
          TextButton(
            child: const Text('حسنا'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Radar',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.grey,
          background: Colors.black,
        ).copyWith(
          surface: const Color(0xFF333333),
        ),
      ),
      home: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: LinearProgressIndicator(
                value: consistencyMeter,
                backgroundColor: Colors.grey[700],
                color: consistencyMeter < 0.5 ? Colors.red : Colors.green,
              ),
            ),
            const Text(
              'مقياس الاستمرارية',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: habits.length,
                itemBuilder: (context, index) {
                  final habit = habits[index];
                  return Card(
                    color: const Color(0xFF444444),
                    child: ListTile(
                      title: Text(
                        habit.name,
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          habit.completed ? Icons.check_circle : Icons.circle,
                          color: habit.completed ? Colors.green : Colors.red,
                        ),
                        onPressed: () => _toggleHabit(habit),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _habitController,
                        decoration: const InputDecoration(
                          labelText: 'إضافة عادة جديدة',
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال اسم للعادة';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: _addHabit,
                      child: const Text('حفظ'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Habit {
  final String name;
  bool completed;

  Habit({required this.name, this.completed = false});

  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      name: json['name'],
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'completed': completed,
    };
  }
}