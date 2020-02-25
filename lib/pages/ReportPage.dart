import 'dart:collection';

import 'package:camp_concierge/structures/Node.dart';
import 'package:camp_concierge/structures/ReportItem.dart';
import 'package:camp_concierge/utils/Helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReportPage extends StatefulWidget {
  ReportPage({Key key, this.report}) : super(key: key);

  final List<ReportItem> report;

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          title: Text("Supervisor's Report"),
        ),
        body: new ListView.builder(
            itemCount: widget.report.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Group: " + widget.report[index].groupId,
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Destination: " + widget.report[index].destinationCaravan,
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.left,
                        )),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Route taken: " + widget.report[index].route,
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.left,
                        )),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Waiting time: " +
                              widget.report[index].waitingTime.toString() +
                              " mins",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.left,
                        ))
                  ],
                ),
              );
            }));
  }
}
