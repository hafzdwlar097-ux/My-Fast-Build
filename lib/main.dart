import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Integrated Suite App',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF4169E1),
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _loadSharedPreferences();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _loadSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('email') != null && prefs.getString('password') != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                focusNode: _emailFocusNode,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
                    return 'Invalid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _saveSharedPreferences();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const DashboardScreen()),
                    );
                  }
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', _emailController.text);
    await prefs.setString('password', _passwordController.text);
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _inventoryCount = 0;
  int _tasksCount = 0;

  @override
  void initState() {
    super.initState();
    _loadSharedPreferences();
  }

  Future<void> _loadSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _inventoryCount = prefs.getInt('inventoryCount') ?? 0;
      _tasksCount = prefs.getInt('tasksCount') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const Text(
                        'Inventory Count',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        _inventoryCount.toString(),
                        style: const TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const Text(
                        'Tasks Status',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        _tasksCount.toString(),
                        style: const TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const InventoryScreen()),
              );
            },
            child: const Text('Inventory'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TasksScreen()),
              );
            },
            child: const Text('Tasks'),
          ),
        ],
      ),
    );
  }
}

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  List<String> _inventoryItems = [];

  @override
  void initState() {
    super.initState();
    _loadSharedPreferences();
  }

  Future<void> _loadSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _inventoryItems = prefs.getStringList('inventoryItems') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _inventoryItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_inventoryItems[index]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _editInventoryItem(index);
                        },
                        child: const Text('Edit'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          _deleteInventoryItem(index);
                        },
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _addInventoryItem();
            },
            child: const Text('Add Item'),
          ),
        ],
      ),
    );
  }

  Future<void> _addInventoryItem() async {
    final prefs = await SharedPreferences.getInstance();
    final newItem = 'Item ${_inventoryItems.length + 1}';
    setState(() {
      _inventoryItems.add(newItem);
    });
    await prefs.setStringList('inventoryItems', _inventoryItems);
  }

  Future<void> _editInventoryItem(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final newItem = 'Item ${index + 1} (edited)';
    setState(() {
      _inventoryItems[index] = newItem;
    });
    await prefs.setStringList('inventoryItems', _inventoryItems);
  }

  Future<void> _deleteInventoryItem(int index) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _inventoryItems.removeAt(index);
    });
    await prefs.setStringList('inventoryItems', _inventoryItems);
  }
}

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<String> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadSharedPreferences();
  }

  Future<void> _loadSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _tasks = prefs.getStringList('tasks') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_tasks[index]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _tasks[index].contains('completed') ? Colors.green : Colors.red,
                        ),
                        onPressed: () {
                          _toggleTaskStatus(index);
                        },
                        child: Text(_tasks[index].contains('completed') ? 'Completed' : 'Not Completed'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _addTask();
            },
            child: const Text('Add Task'),
          ),
        ],
      ),
    );
  }

  Future<void> _addTask() async {
    final prefs = await SharedPreferences.getInstance();
    final newTask = 'Task ${_tasks.length + 1}';
    setState(() {
      _tasks.add(newTask);
    });
    await prefs.setStringList('tasks', _tasks);
  }

  Future<void> _toggleTaskStatus(int index) async {
    final prefs = await SharedPreferences.getInstance();
    if (_tasks[index].contains('completed')) {
      setState(() {
        _tasks[index] = _tasks[index].replaceFirst(' (completed)', '');
      });
    } else {
      setState(() {
        _tasks[index] += ' (completed)';
      });
    }
    await prefs.setStringList('tasks', _tasks);
  }
}