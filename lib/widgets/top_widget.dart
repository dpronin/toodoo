import 'package:flutter/material.dart';
import 'package:toodoo/models/store_model.dart';

class TopWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
              backgroundColor: Colors.white,
              floating: false,
              pinned: true,
              expandedHeight: 200.0,
              flexibleSpace: Container(
                  color: Colors.amber,
                  child: Align(
                    alignment: Alignment.center,
                    child: Icon(Icons.star, size: 50),
                  )),
            );
  }
}
