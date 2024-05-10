import 'package:flutter/material.dart';

import 'main.dart';

class EditTaskScreen extends StatefulWidget {
  final Task task;

  EditTaskScreen({required this.task});

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.task.title;
    _descriptionController.text = widget.task.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.orange.shade300,
        title: Center(child: Text('Edit Task', style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25
        ),)),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pop(
                        context,
                        Task(
                          title: _titleController.text,
                          description: _descriptionController.text,
                          completed: widget.task.completed,
                        ),
                      );
                    }
                  },
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(15), // Removes default elevation
                    backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                    overlayColor: MaterialStateProperty.all(Colors.green),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Save', style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight.bold, color: Colors.orange),),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}