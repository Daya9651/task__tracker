import 'package:flutter/material.dart';
import 'edit_task.dart';
import 'task_item.dart';
import 'add_task.dart';

void main() {
  runApp(TaskTrackerApp());
}

class Task {
  String title;
  String description;
  bool completed;

  Task({required this.title, required this.description, this.completed = false});
}

class TaskTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Tracker',
      theme: ThemeData(
      primarySwatch: Colors.grey,
      ),
      home: TaskListScreen(),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];

  void _addTask(String title, String description) {
    setState(() {
      tasks.add(Task(title: title, description: description));
    });
    _showNotification('Task added successfully');
  }

  void _editTask(int index) async {
    final editedTask = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTaskScreen(task: tasks[index]),
      ),
    );

    if (editedTask != null) {
      setState(() {
        tasks[index] = editedTask;
      });
      _showNotification('Task edited successfully');
    }
  }

  void _toggleTaskCompleted(int index) {
    setState(() {
      tasks[index].completed = !tasks[index].completed;
    });
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
    _showNotification('Task deleted successfully');
  }

  void _showNotification(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.blueAccent,
        content: Text(message,
          style: TextStyle(color: Colors.white),),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade100,
      appBar: AppBar(
        title: Center(child: Text('Task Tracker',
          style: TextStyle(fontWeight: FontWeight.bold)
         )
        ),
        backgroundColor: Colors.orange.shade400,
      ),
      body: tasks.isEmpty
          ? Center(
             child: Text('No tasks yet. Add some tasks!',
               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
      )
          : ListView.builder(
           itemCount: tasks.length,
           itemBuilder: (context, index) {
            final task = tasks[index];
          return TaskItem(
            task: task,
            onToggleCompleted: () => _toggleTaskCompleted(index),
            onEdit: () => _editTask(index),
            onDelete: () => _deleteTask(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );
          if (newTask != null) {
            _addTask(newTask['title'], newTask['description']);
          }
        },
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),
    );
  }
}
