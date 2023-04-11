import 'package:flutter/material.dart';
import 'package:flutter_todo_list/todo_model.dart';

class DoneContainer extends StatelessWidget {
  const DoneContainer({
    super.key,
    this.deleteTap,
    this.onSave,
    required this.todo,
  });

  final Function()? deleteTap;
  final Function? onSave;
  final TodoModel todo;

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
      ),
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          todo.description,
          style: TextStyle(decoration: todo.isDone ? TextDecoration.lineThrough : null),
        ),
        trailing: Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: const Color(0xff6D67E4),
          ),
          child: IconButton(
              onPressed: deleteTap,
              icon: const Icon(
                Icons.delete_rounded,
                size: 20,
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}
