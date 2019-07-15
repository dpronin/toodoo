import 'package:flutter/material.dart';
import '../models/store_model.dart';

class TodoWidget extends StatelessWidget {
  const TodoWidget(this.store);

  final Store store;

  Color color(Priority priority) {
    switch (priority) {
      case Priority.low:
        return Colors.greenAccent.shade100;
        case Priority.medium:
        return Colors.amber.shade100;
        case Priority.high:
        return Colors.redAccent.shade100;
      default:
        return Colors.green.shade100;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
        padding: EdgeInsets.all(10.0),
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(15.0),
        //   color: color(store.priority),
        // ),
        color: color(store.priority),
        child: ListTile(title: Text(store.title)));
  }
}
