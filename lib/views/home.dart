import 'package:flutter/material.dart';
import '../widgets/add_task_dialog.dart';
import 'tasks.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 128, 99, 89),
        centerTitle: true,
        title: const Text("Список дел", style: TextStyle(color: Colors.black),),
      ),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => openAddTaskDialog(context),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BottomAppBar(
        child: SizedBox(
          height: kBottomNavigationBarHeight,
        ),
      ),
      body: PageView(
        controller: pageController,
        children: const <Widget>[
          Center(
            child: Tasks(),
          ),
        ],
      ),
    );
  }

  void openAddTaskDialog(BuildContext context) {
     showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AddTaskAlertDialog();
      },
    );
  }
}
