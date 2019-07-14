import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:toodoo/models/todo_model.dart';
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
    DocumentReference newDoc = collection.document();
    newDoc.setData({"photo": "here"});
  }

  Future _removeTodoItem(DocumentSnapshot document) async {
      await collection.document(document.documentID).delete();
  }
  
  ListView _transformTodo(AsyncSnapshot<QuerySnapshot> snapshot) {
    return ListView(
        children: snapshot.data.documents
            .map((x) =>
            GestureDetector(
                child: TodoWidget(Todo(x.documentID)..title = x.data.toString()),
                onTap: () => _removeTodoItem(x),
              ))                
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
            child: Column(
          children: <Widget>[
            TopWidget([]),
            Flexible(
              child: StreamBuilder<QuerySnapshot>(
                stream: collection.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                    default:
                      return _transformTodo(snapshot);
                  }
                },
              ),
            ),
          ],
        )),
      ),
      floatingActionButton: new FloatingActionButton(
          onPressed: _addTodoItem,
          tooltip: 'Add task',
          child: new Icon(Icons.add)),
    );
  }
}
