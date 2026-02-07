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
        scaffoldBackgroundColor: const Color(0xff000000),
        useMaterial3: true,
        colorScheme: const ColorScheme(
          primary: Color(0xff03a9f4),
          onPrimary: Color(0xff000000),
          secondary: Color(0xff8bc34a),
          onSecondary: Color(0xff000000),
          surface: Color(0xff000000),
          onSurface: Color(0xffffffff),
          background: Color(0xff000000),
          onBackground: Color(0xffffffff),
          error: Color(0xffb00020),
          onError: Color(0xffffffff),
          brightness: Brightness.dark,
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
  List<String> habits = [];
  List<bool> habitStatus = [];
  List<String> habitDescriptions = [];

  Future<void> _getHabits() async {
    final prefs = await SharedPreferences.getInstance();
    final habitList = prefs.getStringList('habits');
    final habitStatusList = prefs.getStringList('habitStatus');
    final habitDescriptionsList = prefs.getStringList('habitDescriptions');

    if (habitList != null) {
      setState(() {
        habits = habitList;
      });
    }

    if (habitStatusList != null) {
      setState(() {
        habitStatus = habitStatusList.map((e) => e == 'true').toList();
      });
    }

    if (habitDescriptionsList != null) {
      setState(() {
        habitDescriptions = habitDescriptionsList;
      });
    }
  }

  Future<void> _saveHabits() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('habits', habits);
    await prefs.setStringList('habitStatus', habitStatus.map((e) => e.toString()).toList());
    await prefs.setStringList('habitDescriptions', habitDescriptions);
  }

  @override
  void initState() {
    super.initState();
    _getHabits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit Tracker'),
      ),
      body: ListView.builder(
        itemCount: habits.length,
        itemBuilder: (context, index) {
          return Card(
            color: const Color(0xff121212),
            elevation: 10,
            child: ListTile(
              title: Text('"' + habits[index] + '"'),
              subtitle: Text('"' + habitDescriptions[index] + '"'),
              trailing: Checkbox(
                value: habitStatus[index],
                onChanged: (value) {
                  setState(() {
                    habitStatus[index] = value ?? false;
                  });
                  _saveHabits();
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              final _habitController = TextEditingController();
              final _habitDescriptionController = TextEditingController();
              return AlertDialog(
                title: const Text('Add Habit'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _habitController,
                      decoration: const InputDecoration(hintText: 'Habit'),
                    ),
                    TextField(
                      controller: _habitDescriptionController,
                      decoration: const InputDecoration(hintText: 'Description'),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        habits.add(_habitController.text);
                        habitStatus.add(false);
                        habitDescriptions.add(_habitDescriptionController.text);
                      });
                      _saveHabits();
                      Navigator.pop(context);
                      _habitController.clear();
                      _habitDescriptionController.clear();
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}