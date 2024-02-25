import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist/widgets/update_task_dialog.dart';

import '../utils/colors.dart';
import '../widgets/delete_task_dialog.dart';

class Tasks extends StatefulWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  final fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: fireStore.collection('tasks').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Text('Нет заметок');
          } else {
            return buildTasksList(snapshot.data!.docs);
          }
        },
      ),
    );
  }

  Widget buildTasksList(List<QueryDocumentSnapshot> documents) {
    return ListView(
      children: documents.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        return buildTaskItem(data);
      }).toList(),
    );
  }

  Widget buildTaskItem(Map<String, dynamic> data) {
    Color taskColor = getTaskColor(data['taskTag']);

    return Container(
      height: 100,
      margin: const EdgeInsets.only(bottom: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: const Color.fromARGB(255, 255, 235, 221),
      ),
      child: ListTile(
        leading: buildTaskAvatar(taskColor),
        title: Text(
          data['taskName'],
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(data['taskDesc'], style: const TextStyle(fontSize: 16)),
        isThreeLine: true,
        trailing: buildPopupMenu(data),
        dense: true,
      ),
    );
  }

  Color getTaskColor(String taskTag) {
    if (taskTag == 'Жизнь') {
      return AppColors.salmonColor;
    } else if (taskTag == 'Университет') {
      return AppColors.greenShadeColor;
    }
    return AppColors.blueShadeColor;
  }

  Widget buildTaskAvatar(Color taskColor) {
    return Container(
      alignment: Alignment.center,
      width: 40,
      height: 40,
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: CircleAvatar(
        backgroundColor: taskColor,
      ),
    );
  }

  Widget buildPopupMenu(Map<String, dynamic> data) {
    return PopupMenuButton(
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: 'edit',
            child: const Text(
              'Изменить',
              style: TextStyle(fontSize: 13.0),
            ),
            onTap: () => showEditDialog(data),
          ),
          PopupMenuItem(
            value: 'delete',
            child: const Text(
              'Удалить',
              style: TextStyle(fontSize: 13.0),
            ),
            onTap: () => showDeleteDialog(data),
          ),
        ];
      },
    );
  }

  void showEditDialog(Map<String, dynamic> data) {
    String taskId = data['id'];
    String taskName = data['taskName'];
    String taskDesc = data['taskDesc'];
    String taskTag = data['taskTag'];
    showDialog(
      context: context,
      builder: (context) =>
          UpdateTaskAlertDialog(taskId: taskId, taskName: taskName, taskDesc: taskDesc, taskTag: taskTag),
    );
  }

  void showDeleteDialog(Map<String, dynamic> data) {
    String taskId = data['id'];
    String taskName = data['taskName'];
    showDialog(
      context: context,
      builder: (context) => DeleteTaskDialog(taskId: taskId, taskName: taskName),
    );
  }
}