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
        flexibleSpace: Padding(
            padding: EdgeInsets.all(20),
            child: Container(
                child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('d3 13 3 131 '),
                AnimatedCircularChart(
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
                ),
                  Text('d3 13 3 131 '),
              ]),
            )))
        );
  }
}
