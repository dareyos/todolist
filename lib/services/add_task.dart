import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final TextEditingController taskNameController = TextEditingController();
final TextEditingController taskDescController = TextEditingController();
final List<String> taskTags = ['Жизнь', 'Университет', 'Другое'];
String selectedValue = '';


Future addTasks({required String taskName, required String taskDesc, required String taskTag}) async {
    DocumentReference docRef = await FirebaseFirestore.instance.collection('tasks').add(
      {
        'taskName': taskName,
        'taskDesc': taskDesc,
        'taskTag': taskTag,
      },
    );
    String taskId = docRef.id;
    await FirebaseFirestore.instance.collection('tasks').doc(taskId).update(
      {'id': taskId},
    );
    _clearAll();
  }

  void _clearAll() {
    taskNameController.text = '';
    taskDescController.text = '';
  }