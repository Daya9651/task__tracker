import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTaskScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  late DateTime _dueDate;

  AddTaskScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade100,
      appBar: AppBar(
        title: Center(
          child: Text('Add Task' , style: TextStyle(fontWeight: FontWeight.bold
          ),),
        ),
        backgroundColor: Colors.orange.shade300,
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
                        {
                          'title': _titleController.text,
                          'description': _descriptionController.text,
                        },
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
                       child: Text('Add', style: TextStyle(fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange),
                      ),
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
