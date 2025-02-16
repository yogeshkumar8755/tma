
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tma/models/task_model.dart';
import 'package:tma/service/database_helper.dart';
import 'package:tma/utils/connectivity.dart';


class TaskProvider with ChangeNotifier {
  final DatabaseHelper databaseHelper = DatabaseHelper();
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  
  Future<void> fetchTasks() async {
    final isConnected = await ConnectivityService.isConnected();

    if (isConnected) {
      
      await databaseHelper.syncTasksWithFirebase();

      
      _tasks = await databaseHelper.fetchTasksFromFirebase();
    } else {
      
      _tasks = await databaseHelper.getTasks();
    }

    notifyListeners();
  }

  
  Future<void> addTask(Task task) async {
    final isConnected = await ConnectivityService.isConnected();

    if (isConnected) {
      
      print(isConnected);

      await databaseHelper.syncTasksWithFirebase();
      // CollectionReference addTicket =
      //     FirebaseFirestore.instance.collection('Ticket');

      // await addTicket.add({
      //   "studentName": task.title,
      //   "fatherName": task.title,
      //   "mobile": task.title,
      //   "roleNumber": task.title,
      //   "studentClass": task.title,
      //   "address": task.title,
      //   "dateTime": task.title
      // });
      // await _firebaseDatabase.ref().child('Ticket').push().set({
      //   'address': task.title,
        // 'description': task.description,
        // 'status': task.status,
      // });
      // notifyListeners();
    } else {
      
      await databaseHelper.insertTask(task);
    }

    await fetchTasks(); 
  }

  
  Future<void> updateTask(Task task) async {
    final isConnected = await ConnectivityService.isConnected();

    if (isConnected) {
      
      await databaseHelper.syncTasksWithFirebase();
    } else {
      
      await databaseHelper.updateTask(task);
    }

    await fetchTasks(); 
  }

  
  Future<void> deleteTask(int id) async {
    final isConnected = await ConnectivityService.isConnected();

    if (isConnected) {
      
      await databaseHelper.syncTasksWithFirebase();
    } else {
      
      await databaseHelper.deleteTask(id);
    }

    await fetchTasks(); 
  }
}
