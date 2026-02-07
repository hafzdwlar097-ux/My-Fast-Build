```dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      theme: ThemeData(
        useMaterial3: true,
        backgroundColor: const Color(0xFF000000),
        cardColor: const Color(0xFF333333),
        cardTheme: const CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
      ),
      home: const HabitTracker(),
    );
  }
}

class HabitTracker extends StatefulWidget {
  const HabitTracker({super.key});

  @override
  State<HabitTracker> createState() => _HabitTrackerState();
}

class _HabitTrackerState extends State<HabitTracker> {
  final List<Habit> _habits = [];
  final _habitController = TextEditingController();

  void _addHabit() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_habitController.text.isNotEmpty) {
      final habit = Habit(
        title: _habitController.text,
        isCompleted: false,
        frequency: 0,
      );
      setState(() {
        _habits.add(habit);
        _habitController.clear();
      });
      await prefs.setString('habits', jsonEncode(_habits.map((habit) => habit.toJson()).toList()));
    }
  }

  void _toggleHabit(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _habits[index].isCompleted = !_habits[index].isCompleted;
      if (_habits[index].isCompleted) {
        _habits[index].frequency++;
      }
    });
    await prefs.setString('habits', jsonEncode(_habits.map((habit) => habit.toJson()).toList()));
  }

  void _removeHabit(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _habits.removeAt(index);
    });
    await prefs.setString('habits', jsonEncode(_habits.map((habit) => habit.toJson()).toList()));
  }

  void _loadHabits() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? habitsJson = prefs.getString('habits');
    if (habitsJson != null) {
      final List<Habit> habits = jsonDecode(habitsJson).map((habitJson) => Habit.fromJson(habitJson)).toList();
      setState(() {
        _habits.addAll(habits);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadHabits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit Tracker'),
      ),
      body: Container(
        color: const Color(0xFF000000),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _habitController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Add Habit',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _addHabit,
              child: const Text('Add'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _habits.isEmpty
                  ? const Center(
                      child: Text('No habits added'),
                    )
                  : ListView.builder(
                      itemCount: _habits.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(_habits[index].title),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: _habits[index].isCompleted,
                                  onChanged: (value) => _toggleHabit(index),
                                ),
                                Text('Completed ${_habits[index].frequency} times'),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => _removeHabit(index),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class Habit {
  String title;
  bool isCompleted;
  int frequency;

  Habit({
    required this.title,
    this.isCompleted = false,
    this.frequency = 0,
  });

  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      title: json['title'],
      isCompleted: json['isCompleted'],
      frequency: json['frequency'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isCompleted': isCompleted,
      'frequency': frequency,
    };
  }
}
```