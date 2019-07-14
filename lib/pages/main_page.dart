import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:toodoo/models/store_model.dart';
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
    DocumentReference Doc = collection.document();
    Doc.setData(
        (Store(Doc.documentID)
              ..title = 'title: ${DateTime.now()}'
              ..priority = Priority.low)
            .toSnapshot(),
        merge: true);
  }

  Future _removeTodoItem(DocumentSnapshot document) async {
    await collection.document(document.documentID).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            ///First sliver is the App Bar
            SliverAppBar(
              ///Properties of app bar
              backgroundColor: Colors.white,
              floating: false,
              pinned: true,
              expandedHeight: 200.0,

              ///Properties of the App Bar when it is expanded
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  "SliverGrid Widget",
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.black26,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: collection.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return GestureDetector(
                      child: TodoWidget(
                          Store.fromSnapshot(snapshot.data.documents[index])),
                      onTap: () =>
                          _removeTodoItem(snapshot.data.documents[index]),
                    );
                  },
                      childCount: snapshot.hasData
                          ? snapshot.data.documents.length
                          : 0),
                );
              },
            )
          ],
        ),
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
