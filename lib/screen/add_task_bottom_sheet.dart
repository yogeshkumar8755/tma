import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tma/models/task_model.dart';
import '../providers/task_provider.dart';


class AddTaskBottomSheet extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
 

    return AlertDialog(
      title: Text('Add Task'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              
              final task = Task(
                title: _titleController.text,
                description: _descriptionController.text,
              );
              print("object");
              
              await Provider.of<TaskProvider>(context, listen: false)
                  .addTask(task);

              
              Navigator.pop(context);
            }
          },
          child: Text('Add'),
        ),

      
      ],
    );
  }


}


class UpdateTaskDialog extends StatelessWidget {
  final Task task;
  final Function(Task) onUpdate;

  UpdateTaskDialog({required this.task, required this.onUpdate});

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    _titleController.text = task.title;
    _descriptionController.text = task.description;

    return AlertDialog(
      title: Text('Update Task'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Create an updated task
              final updatedTask = Task(
                id: task.id,
                title: _titleController.text,
                description: _descriptionController.text,
                status: task.status,
              );

              // Call the onUpdate callback
              onUpdate(updatedTask);

              // Close the dialog
              Navigator.pop(context);
            }
          },
          child: Text('Update'),
        ),
      ],
    );
  }
}
