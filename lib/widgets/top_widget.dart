import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class TopWidget extends StatelessWidget {
  const TopWidget(this._chartKey, this._snapshot);

  final GlobalKey<AnimatedCircularChartState> _chartKey;
  final AsyncSnapshot<QuerySnapshot> _snapshot;

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
                    child:  AnimatedCircularChart(
                      key: _chartKey,
                      size: Size.fromRadius(100),
                      initialChartData: <CircularStackEntry>[
                        new CircularStackEntry(
                          <CircularSegmentEntry>[
                            new CircularSegmentEntry(
                              33.3,
                              Colors.greenAccent.shade200,
                              rankKey: 'low',
                            ),
                            new CircularSegmentEntry(
                              33.3,
                              Colors.amberAccent.shade200,
                              rankKey: 'medium',
                            ),
                            new CircularSegmentEntry(
                              33.3,
                              Colors.redAccent.shade200,
                              rankKey: 'height',
                            ),
                          ],
                          rankKey: 'progress',
                        ),
                      ],
                      chartType: CircularChartType.Radial,
                      percentageValues: true,
                      // holeLabel: priorities.toString(),
                      labelStyle: new TextStyle(
                        color: Colors.blueGrey[600],
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    )
                  )),
            );
  }
}
