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
                scaffoldBackgroundColor: const Color(0xFF000000),
                cardColor: const Color(0xFF333333),
                textTheme: const TextTheme(
                    headline1: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 24,
                    ),
                    headline2: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 18,
                    ),
                ),
            ),
            home: const MyHomePage(),
        );
    }
}

class MyHomePage extends StatefulWidget {
    const MyHomePage({super.key});

    @override
    State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    final List<Habit> _habits = [];
    final _textController = TextEditingController();

    Future<void> _saveHabits() async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('habits', jsonEncode(_habits));
    }

    Future<void> _loadHabits() async {
        final prefs = await SharedPreferences.getInstance();
        final habitsString = prefs.getString('habits');
        if (habitsString != null) {
            final List<Map<String, dynamic>> habitsMap = jsonDecode(habitsString);
            setState(() {
                _habits.addAll(habitsMap.map((habit) => Habit(
                    habit['name'],
                    habit['done'],
                )).toList());
            });
        }
    }

    @override
    void initState() {
        super.initState();
        _loadHabits();
    }

    void _addHabit() {
        setState(() {
            _habits.add(Habit(_textController.text, false));
            _saveHabits();
            _textController.clear();
        });
    }

    void _toggleHabit(int index) {
        setState(() {
            _habits[index].done = !_habits[index].done;
            _saveHabits();
        });
    }

    void _removeHabit(int index) {
        setState(() {
            _habits.removeAt(index);
            _saveHabits();
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Habit Tracker'),
            ),
            body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    children: [
                        Row(
                            children: [
                                Expanded(
                                    child: TextField(
                                        controller: _textController,
                                        style: const TextStyle(
                                            color: Color(0xFFFFFFFF),
                                        ),
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintStyle: TextStyle(
                                                color: Color(0xFFFFFFFF),
                                            ),
                                            hintText: 'New Habit',
                                        ),
                                    ),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                    onPressed: _addHabit,
                                    child: const Text('Add'),
                                ),
                            ],
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                            child: _habits.isEmpty
                                ? const Center(
                                    child: Text('No Habits Added'),
                                )
                                : ListView.builder(
                                    itemCount: _habits.length,
                                    itemBuilder: (context, index) {
                                        return Card(
                                            child: ListTile(
                                                leading: Checkbox(
                                                    value: _habits[index].done,
                                                    onChanged: (value) {
                                                        _toggleHabit(index);
                                                    },
                                                ),
                                                title: Text(
                                                    _habits[index].name,
                                                ),
                                                trailing: IconButton(
                                                    icon: const Icon(Icons.delete),
                                                    onPressed: () {
                                                        _removeHabit(index);
                                                    },
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
    final String name;
    bool done;

    Habit(this.name, this.done);

    Map<String, dynamic> toJson() {
        return {
            'name': name,
            'done': done,
        };
    }
}
```