import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:to_do/main.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              label: 'TRASH',
              spacing: 5.0,
              onPressed: deleteFunction,
              backgroundColor:
                  isDark ? Colors.grey.shade400 : Colors.deepPurple.shade600,
              icon: Icons.delete,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(100),
                bottomRight: Radius.circular(100),
              ),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: isDark ? Colors.grey.shade800 : Colors.deepPurple.shade400,
            border: Border.all(
                width: 3,
                color: isDark ? Colors.black54 : Colors.deepPurple.shade600),
            boxShadow: [
              BoxShadow(
                  offset: Offset(-10, 10),
                  color: Colors.black54,
                  blurRadius: 5),
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(100),
              bottomLeft: Radius.circular(100),
            ),
          ),
          child: Row(
            children: [
              /// Checkbox
              Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                value: taskCompleted,
                onChanged: onChanged,
                activeColor:
                    isDark ? Colors.grey.shade900 : Colors.deepPurple.shade900,
              ),

              /// Task name
              Expanded(
                child: Text(
                  taskName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    decoration: taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
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
