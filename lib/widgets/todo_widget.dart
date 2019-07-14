import 'package:flutter/material.dart';
import '../models/todo_model.dart';

class TodoWidget extends StatelessWidget {
  const TodoWidget(this.todo);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.amber.shade100,
        ),
        child: ListTile(title: Text(todo.title)));
  }
}
