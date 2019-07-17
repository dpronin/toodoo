import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class TopWidget extends StatelessWidget {
  const TopWidget(this._chartKey);

  final GlobalKey<AnimatedCircularChartState> _chartKey;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        floating: false,
        pinned: true,
        backgroundColor: Colors.white,
        expandedHeight: 260.0,
        flexibleSpace: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          final top = constraints.biggest.height;
          return Padding(
              padding: EdgeInsets.all(top / 10),
              child: Container(
                color: Colors.white,
                child: Center(
                  child: AnimatedCircularChart(
                    key: _chartKey,
                    holeRadius: 10,
                    size: Size.fromRadius(40),
                    initialChartData: <CircularStackEntry>[
                      new CircularStackEntry(
                        <CircularSegmentEntry>[
                          new CircularSegmentEntry(
                            33.3,
                            Colors.greenAccent.shade200,
                          ),
                          new CircularSegmentEntry(
                            33.3,
                            Colors.amberAccent.shade200,
                          ),
                          new CircularSegmentEntry(
                            33.3,
                            Colors.redAccent.shade200,
                          ),
                        ],
                      ),
                    ],
                    chartType: CircularChartType.Radial,
                    percentageValues: true,
                    labelStyle: new TextStyle(
                      color: Colors.blueGrey[600],
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ));
          // ),
          // background: Image.network(
          //   "https://images.unsplash.com/photo-1542601098-3adb3baeb1ec?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=5bb9a9747954cdd6eabe54e3688a407e&auto=format&fit=crop&w=500&q=60",
          //   fit: BoxFit.cover,
        }));
  }
}
