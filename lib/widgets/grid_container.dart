import 'package:flutter/material.dart';
import 'package:flutter_todo_list/todo_model.dart';

class GridContainerWidget extends StatelessWidget {
  const GridContainerWidget({
    super.key,
    this.checkTap,
    this.deleteTap,
    required this.todo,
    this.onSave,
  });
  final Function()? checkTap;
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
        leading: IconButton(
            onPressed: checkTap,
            icon: AnimatedRotation(
              duration: const Duration(milliseconds: 500),
              turns: todo.isDone ? 0 : -1,
              child: AnimatedCrossFade(
                firstChild: const Icon(
                  Icons.check_box_rounded,
                  color: Color(0xff6D67E4),
                ),
                secondChild: const Icon(
                  Icons.check_box_outline_blank_rounded,
                  color: Color(0xff6D67E4),
                ),
                crossFadeState: todo.isDone ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 500),
              ),
            )),
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
