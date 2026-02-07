import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Integrated Suite App',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF1A1D23),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4169E1), // Royal Blue
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  } else if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  } else if (value.length < 8) {
                    return 'Password must be at least 8 characters long';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString('email', _emailController.text);
                    await prefs.setString('password', _passwordController.text);
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
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _prefs = SharedPreferences.getInstance();

  int _inventoryCount = 0;
  int _tasksCount = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await _prefs;
    final inventoryJson = prefs.getString('inventory');
    final tasksJson = prefs.getString('tasks');
    if (inventoryJson != null) {
      final inventory = jsonDecode(inventoryJson) as List;
      setState(() {
        _inventoryCount = inventory.length;
      });
    }
    if (tasksJson != null) {
      final tasks = jsonDecode(tasksJson) as List;
      setState(() {
        _tasksCount = tasks.length;
      });
    }
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
              _summaryCard('Inventory', _inventoryCount),
              _summaryCard('Tasks', _tasksCount),
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
                MaterialPageRoute(builder: (context) => const TaskScreen()),
              );
            },
            child: const Text('Tasks'),
          ),
        ],
      ),
    );
  }

  Widget _summaryCard(String title, int count) {
    return Card(
      color: Colors.grey.shade800,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              count.toString(),
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final _prefs = SharedPreferences.getInstance();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  List _inventory = [];

  @override
  void initState() {
    super.initState();
    _loadInventory();
  }

  Future<void> _loadInventory() async {
    final prefs = await _prefs;
    final inventoryJson = prefs.getString('inventory');
    if (inventoryJson != null) {
      setState(() {
        _inventory = jsonDecode(inventoryJson) as List;
      });
    }
  }

  Future<void> _saveInventory() async {
    final prefs = await _prefs;
    await prefs.setString('inventory', jsonEncode(_inventory));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _inventory.isEmpty
                ? const Center(child: Text('No items in inventory'))
                : ListView.builder(
                    itemCount: _inventory.length,
                    itemBuilder: (context, index) {
                      final item = _inventory[index];
                      return ListTile(
                        title: Text(item['name']),
                        subtitle: Text('Price: ${item['price']} | Stock: ${item['stock']}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                _editItem(index);
                              },
                              child: const Text('Edit'),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                _deleteItem(index);
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _priceController,
                    decoration: const InputDecoration(
                      labelText: 'Price',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a price';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _stockController,
                    decoration: const InputDecoration(
                      labelText: 'Stock',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a stock';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _inventory.add({
                            'name': _nameController.text,
                            'price': _priceController.text,
                            'stock': _stockController.text,
                          });
                        });
                        await _saveInventory();
                        _nameController.clear();
                        _priceController.clear();
                        _stockController.clear();
                      }
                    },
                    child: const Text('Add Item'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _editItem(int index) {
    final item = _inventory[index];
    _nameController.text = item['name'];
    _priceController.text = item['price'];
    _stockController.text = item['stock'];
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Item'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a price';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _stockController,
                  decoration: const InputDecoration(
                    labelText: 'Stock',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a stock';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _inventory[index] = {
                      'name': _nameController.text,
                      'price': _priceController.text,
                      'stock': _stockController.text,
                    };
                  });
                  await _saveInventory();
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteItem(int index) {
    setState(() {
      _inventory.removeAt(index);
    });
    _saveInventory();
  }
}

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final _prefs = SharedPreferences.getInstance();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _statusController = TextEditingController();
  List _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await _prefs;
    final tasksJson = prefs.getString('tasks');
    if (tasksJson != null) {
      setState(() {
        _tasks = jsonDecode(tasksJson) as List;
      });
    }
  }

  Future<void> _saveTasks() async {
    final prefs = await _prefs;
    await prefs.setString('tasks', jsonEncode(_tasks));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _tasks.isEmpty
                ? const Center(child: Text('No tasks'))
                : ListView.builder(
                    itemCount: _tasks.length,
                    itemBuilder: (context, index) {
                      final task = _tasks[index];
                      return ListTile(
                        title: Text(task['name']),
                        subtitle: Text('Status: ${task['status']}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                _editTask(index);
                              },
                              child: const Text('Edit'),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                _deleteTask(index);
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _statusController,
                    decoration: const InputDecoration(
                      labelText: 'Status',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a status';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _tasks.add({
                            'name': _nameController.text,
                            'status': _statusController.text,
                          });
                        });
                        await _saveTasks();
                        _nameController.clear();
                        _statusController.clear();
                      }
                    },
                    child: const Text('Add Task'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _editTask(int index) {
    final task = _tasks[index];
    _nameController.text = task['name'];
    _statusController.text = task['status'];
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Task'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _statusController,
                  decoration: const InputDecoration(
                    labelText: 'Status',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a status';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _tasks[index] = {
                      'name': _nameController.text,
                      'status': _statusController.text,
                    };
                  });
                  await _saveTasks();
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
    _saveTasks();
  }
}