import 'package:flutter/material.dart';
import 'package:toodoo/models/store_model.dart';

class FunkyOverlay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FunkyOverlayState();
}

class FunkyOverlayState extends State<FunkyOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 150));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
              height: 200,
              width: 300,
              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: TextField(
                      controller: myController,
                      maxLines: 2,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter a search term'),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: IconButton(
                                icon: Icon(Icons.subdirectory_arrow_right),
                                onPressed: () =>
                                    Navigator.pop(context, {'priority' : Priority.low, 'title': myController.text})),
                          ),
                          Expanded(
                            child: IconButton(
                                icon: Icon(Icons.system_update_alt),
                                onPressed: () =>
                                    Navigator.pop(context, {'priority' : Priority.medium, 'title': myController.text})),
                          ),
                          Expanded(
                            child: IconButton(
                                icon: Icon(Icons.surround_sound),
                                onPressed: () =>
                                    Navigator.pop(context, {'priority' : Priority.high, 'title': myController.text})),
                          ),
                        ],
                      ))
                ],
                // ),
              )),
          // ),
        ),
      ),
    );
  }
}
