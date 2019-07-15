import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:toodoo/models/store_model.dart';
import 'package:toodoo/widgets/edit_dialog_widget.dart';
import 'package:toodoo/widgets/todo_widget.dart';
import 'package:toodoo/widgets/top_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  CollectionReference collection = Firestore.instance.collection('todos');

  void _addTodoItem() {
    DocumentReference doc = collection.document();
    doc.setData(
        (Store(doc.documentID)
              ..title = ''
              ..priority = Priority.low)
            .toSnapshot(),
        merge: true);
  }

  Future _removeTodoItem(DocumentSnapshot document) async {
    await collection.document(document.documentID).delete();
  }

  Future _updateTodo(DocumentSnapshot document, dynamic x) {
    collection.document(document.documentID).updateData(
        {'priority': x['priority'].index, 'title': x['title'] = x['title']});
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
                    final todo = Store.fromSnapshot(
                              snapshot.data.documents[index]);
                    return GestureDetector(
                        child: Slidable(
                          actionPane: SlidableDrawerActionPane(),
                          actionExtentRatio: 0.25,
                          child: TodoWidget(todo),
                          actions: <Widget>[
                            IconSlideAction(
                              caption: 'Share',
                              color: Colors.indigo,
                              icon: Icons.share,
                            ),
                          ],
                          secondaryActions: <Widget>[
                            IconSlideAction(
                              caption: 'Delete',
                              color: Colors.red,
                              icon: Icons.delete,
                              onTap: () => _removeTodoItem(snapshot.data.documents[index]),
                            ),
                          ],
                        ),
                        onTap: () => showDialog(
                              context: context,
                              builder: (_) => FunkyOverlay(todo),
                            ).then((x) => _updateTodo(
                                snapshot.data.documents[index], x)));
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
