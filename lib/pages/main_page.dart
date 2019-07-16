import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
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
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();
  var _documents = <DocumentSnapshot>[];

  void _addTodoItem() {
    DocumentReference doc = collection.document();
    doc.setData(
        (Store(doc.documentID)
              ..title = ''
              ..priority = Priority.low)
            .toSnapshot(),
        merge: true);
  }

  _ipdateDocuments(List<DocumentSnapshot> documents) {
    setState(() {
      _documents = documents;
    });
  }

  Future _removeTodoItem(DocumentSnapshot document) async {
    await collection.document(document.documentID).delete();
  }

  Future _updateTodo(DocumentSnapshot document, dynamic x) {
    return collection.document(document.documentID).updateData(
        {'priority': x['priority'].index, 'title': x['title'] = x['title']});
  }

  @override
  Widget build(BuildContext context) {
    final stream = collection.orderBy('priority', descending: true).snapshots();
    return Scaffold(
        body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
              stream: stream,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                var priorities = groupBy(snapshot.data.documents, (x) => x['priority']);
                if (!priorities.containsKey(0)) priorities[0] = [];
                if (!priorities.containsKey(1)) priorities[1] = [];
                if (!priorities.containsKey(2)) priorities[2] = [];
                final totalLength = priorities.values.fold(0, (x, y) => 1.0 * x + y.length);
                final low = priorities[0].length * 100.0 / totalLength;
                final medium = priorities[1].length * 100.0 / totalLength;
                final high = priorities[2].length * 100.0  / totalLength;
                List<CircularStackEntry> nextData = <CircularStackEntry>[
                  new CircularStackEntry(
                    <CircularSegmentEntry>[
                      new CircularSegmentEntry(low, Colors.greenAccent.shade200,
                          rankKey: 'Q1'),
                      new CircularSegmentEntry(medium, Colors.amberAccent.shade200,
                          rankKey: 'Q2'),
                      new CircularSegmentEntry(high, Colors.redAccent.shade200,
                          rankKey: 'Q3'),
                    ],
                    rankKey: 'Quarterly Profits',
                  ),
                ];
                _chartKey.currentState.updateData(nextData);
                return CustomScrollView(
                  slivers: <Widget>[
                    TopWidget(_chartKey, snapshot),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final todo =
                            Store.fromSnapshot(snapshot.data.documents[index]);
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
                                  onTap: () => _removeTodoItem(
                                      snapshot.data.documents[index]),
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
                    ),
                  ],
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _addTodoItem(),
          backgroundColor: Colors.amber,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          foregroundColor: Colors.pink,
        ));
  }
}
