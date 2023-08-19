import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:iconly/iconly.dart';
import '../data/database.dart';
import '../util/dialog_box.dart';
import '../util/todo_list.dart';
import 'package:to_do/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Reference the hive box
  final _myBox = Hive.box('myBox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    /// If  this is the 1st time ever opening the app
    if (_myBox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      /// the already exists data
      db.loadData();
    }

    super.initState();
  }

  /// Text controller
  final _controller = TextEditingController();

  /// Checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  /// Save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  /// Create New Task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          onClear: () => _controller.clear(),
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  /// Delete Task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          isDark ? Colors.grey.shade900 : Colors.deepPurple.shade300,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isDark = !isDark;
              });
            },
            icon: isDark
                ? Icon(
                    Icons.dark_mode_outlined,
                  )
                : Icon(
                    Icons.light_mode_outlined,
                  ),
          ),
        ],
        title: const Text(
          'ToDo',
          style: TextStyle(
            fontFamily: 'Ubuntu',
            letterSpacing: 1.2,
            fontSize: 26,
          ),
        ),
        centerTitle: true,
        elevation: 10,
        backgroundColor:
            isDark ? Colors.grey.shade900 : Colors.deepPurple.shade500,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor:
            isDark ? Colors.grey.shade800 : Colors.deepPurple.shade500,
        child: const Icon(
          IconlyLight.plus,
          color: Color(0xFFFFFFFF),
        ),
      ),
      body: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteFunction: (context) => deleteTask(index),
            );
          }),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(IconlyBold.home), label: 'home'),
          BottomNavigationBarItem(icon: Icon(IconlyBold.plus), label: 'menu'),
          BottomNavigationBarItem(icon: Icon(IconlyBold.setting), label: 'setting'),
        ],
      ),
    );
  }
}
