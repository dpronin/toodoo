import 'package:flutter/material.dart';
import 'package:toodoo/models/todo_model.dart';

class TopWidget extends StatelessWidget {
  const TopWidget(this.todos);

  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      height: 200,
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.green.shade100,
      ),
      child: Text('${todos.length}', style: TextStyle(fontSize: 30)),
    );
  }
}
