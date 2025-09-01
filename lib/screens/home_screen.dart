import 'package:flutter/material.dart';
import '../models/task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Task> _tasks = [];

  void _addTask(Task task) {
    setState(() {
      _tasks.add(task);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Tarea añadida ✅')),
    );
  }

  void _toggleTask(int index, bool? value) {
    setState(() {
      _tasks[index].completed = value ?? false;
    });
  }

  void _deleteTask(int index) {
    final removedTask = _tasks[index];
    setState(() {
      _tasks.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Eliminaste: ${removedTask.title} 🗑️')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis Tareas')),
      body: _tasks.isEmpty
          ? const Center(child: Text('No tienes tareas aún ✨'))
          : ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return ListTile(
                  leading: Checkbox(
                    value: task.completed,
                    onChanged: (val) => _toggleTask(index, val),
                  ),
                  title: Text(task.title),
                  subtitle: Text(
                    task.description.isEmpty
                        ? 'Sin descripción'
                        : task.description,
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteTask(index),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/detail', arguments: task);
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final newTask =
              await Navigator.pushNamed(context, '/add') as Task?;
          if (newTask != null) _addTask(newTask);
        },
        icon: const Icon(Icons.add),
        label: const Text('Añadir tarea'),
      ),
    );
  }
}








