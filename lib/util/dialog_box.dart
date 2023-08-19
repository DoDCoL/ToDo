import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'my_button.dart';
import 'package:to_do/main.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  VoidCallback onClear;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:
          isDark ? Colors.grey.shade900 : Colors.deepPurple.shade300,
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// Get user input
            TextField(
              cursorColor: Colors.white,
              cursorHeight: 16,
              controller: controller,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: onClear,
                  icon: Icon(
                    IconlyLight.close_square,
                    color: Colors.grey.shade400,
                    size: 27,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                hintText: ' INPUT . . . .',
                hintStyle: TextStyle(color: Colors.grey.shade400),
              ),
            ),

            /// Buttons -> save + cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Save button
                MyButton(
                  text: 'Save',
                  onPressed: onSave,
                ),

                /// Cancel button
                MyButton(
                  text: 'Cancel',
                  onPressed: onCancel,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
