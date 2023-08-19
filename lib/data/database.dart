import 'package:hive/hive.dart';

class ToDoDataBase {
  List toDoList = [];

  /// Reference our box
  final _myBox = Hive.box('myBox');

  /// Run this method if this is the 1st time ever opening this app
  void createInitialData() {
    toDoList = [];
  }

  /// Load the data from dataBase
  void loadData() {
    toDoList = _myBox.get('TODOLIST');
  }

  /// Update dataBase
  void updateDataBase() {
    _myBox.put('TODOLIST', toDoList);
  }
}
