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
        colorScheme: const ColorScheme.dark(),
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
  List<Habit> _habits = [];
  final _controller = TextEditingController();

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
            Expanded(
              child: _habits.isEmpty
                  ? const Center(
                      child: Text('No habits'),
                    )
                  : ListView.builder(
                      itemCount: _habits.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: const Color(0xFF333333),
                          child: ListTile(
                            title: Text(_habits[index].name),
                            trailing: Text(_habits[index].streak.toString()),
                            leading: Checkbox(
                              value: _habits[index].completed,
                              onChanged: (value) {
                                setState(() {
                                  _habits[index].completed = value ?? false;
                                  _saveHabits();
                                  if (value ?? false) {
                                    _habits[index].streak++;
                                  } else {
                                    _habits[index].streak = 0;
                                  }
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        filled: true,
                        labelText: 'Add new habit',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_controller.text.isNotEmpty) {
                          _habits.add(Habit(_controller.text));
                          _saveHabits();
                          _controller.clear();
                        }
                      });
                    },
                    child: const Text('Add'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _loadHabits() async {
    final prefs = await SharedPreferences.getInstance();
    final habitsJson = prefs.getString('habits');
    if (habitsJson != null) {
      final habits = jsonDecode(habitsJson).map((json) => Habit.fromJson(json)).toList();
      setState(() {
        _habits = habits;
      });
    }
  }

  void _saveHabits() async {
    final prefs = await SharedPreferences.getInstance();
    final habitsJson = jsonEncode(_habits.map((habit) => habit.toJson()).toList());
    prefs.setString('habits', habitsJson);
  }
}

class Habit {
  String name;
  bool completed;
  int streak;

  Habit(this.name, {this.completed = false, this.streak = 0});

  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      json['name'],
      completed: json['completed'],
      streak: json['streak'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'completed': completed,
      'streak': streak,
    };
  }
}
```