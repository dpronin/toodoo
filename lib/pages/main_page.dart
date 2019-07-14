import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:toodoo/models/store_model.dart';
import 'package:toodoo/widgets/edit_dialog_widget.dart';
import 'package:toodoo/widgets/todo_widget.dart';
import 'package:toodoo/widgets/top_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  CollectionReference collection = Firestore.instance.collection('users');

  void _addTodoItem() {
    DocumentReference doc = collection.document();
    final title = 'title: ${DateTime.now()}';
    final ran = Random().nextInt(3);
    final priority =
        ran == 1 ? Priority.low : ran == 0 ? Priority.medium : Priority.high;
    doc.setData(
        (Store(doc.documentID)
              ..title = title
              ..priority = priority)
            .toSnapshot(),
        merge: true);
  }

  Future _removeTodoItem(DocumentSnapshot document) async {
    await collection.document(document.documentID).delete();
  }

  Future _updateTodo(DocumentSnapshot document, dynamic x) {
    collection.document(document.documentID).updateData({'priority' : x['priority'].index, 'title': x['title'] = x['title']});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: CustomScrollView(
          slivers: <Widget>[
            TopWidget(),
            StreamBuilder<QuerySnapshot>(
              stream:
                  collection.orderBy('priority', descending: true).snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return GestureDetector(
                        child: TodoWidget(
                            Store.fromSnapshot(snapshot.data.documents[index])),
                        onTap: () => showDialog(
                              context: context,
                              builder: (_) => FunkyOverlay(),
                            ).then((x) => _updateTodo(snapshot.data.documents[index], x))
                        );
                  },
                      childCount: snapshot.hasData
                          ? snapshot.data.documents.length
                          : 0),
                );
              },
            )
          ],
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _addTodoItem(),
          child: Icon(
            Icons.add,
            color: Colors.yellow,
          ),
          foregroundColor: Colors.pink,
        ));
  }
}
