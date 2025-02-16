
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tma/screen/add_task_bottom_sheet.dart';
import '../providers/task_provider.dart';


class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  void initState() {
    super.initState();
    
    Provider.of<TaskProvider>(context, listen: false).fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Consumer<TaskProvider>(
              builder: (context, state, c) {
                return IconButton(
                    onPressed: () {
                      state.databaseHelper.syncTasksWithFirebase();
                    },
                    icon: Icon(Icons.sync));
              },
            )
          ],
        ),
        body: Consumer<TaskProvider>(
          builder: (context, taskProvider, child) {
            if (taskProvider.tasks.isEmpty) {
              return Center(child: Text('No tasks found.'));
            } else {
              return ListView.builder(
                itemCount: taskProvider.tasks.length,
                itemBuilder: (context, index) {
                  final task = taskProvider.tasks[index];
                  return ListTile(
                    title: Text(task.title),
                    subtitle: Text(task.description),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            
                            showDialog(
                              context: context,
                              builder: (context) => UpdateTaskDialog(
                                task: task,
                                onUpdate: (updatedTask) async {
                                  
                                  await taskProvider.updateTask(updatedTask);
                                },
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            
                            await taskProvider.deleteTask(task.id!);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
        floatingActionButton:
            Consumer<TaskProvider>(builder: (context, taskProvider, child) {
          return FloatingActionButton(
            onPressed: () async {
              showDialog(
                  context: context, builder: (context) => AddTaskBottomSheet());
              
            },
            child: Icon(Icons.add),
          );
        }));
  }
}
