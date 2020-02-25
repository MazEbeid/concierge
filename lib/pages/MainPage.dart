import 'dart:collection';

import 'package:camp_concierge/pages/ReportPage.dart';
import 'package:camp_concierge/pages/SettingsPage.dart';
import 'package:camp_concierge/structures/Node.dart';
import 'package:camp_concierge/structures/ReportItem.dart';
import 'package:camp_concierge/utils/Helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.groups}) : super(key: key);

  final List<dynamic> groups;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //build the campsite
  Node gate = Node("0");
  Node c1 = Node("1");
  Node c2 = Node("2");
  Node c3 = Node("3");
  Node c4 = Node("4");
  Node c5 = Node("5");
  Node c6 = Node("6");
  Node c7 = Node("7");
  Node c8 = Node("8");
  Node c9 = Node("9");
  Node c10 = Node("10");
  Node c11 = Node("11");
  Node c12 = Node("12");
  Node c13 = Node("13");
  Node c14 = Node("14");
  Node c15 = Node("15");
  Node c16 = Node("16");
  List<Node> campsite;
  List<Node> initializedCamp;
  List<ReportItem> report;
  Widget bodyWidget, initialWidget, meetAndGreetWidget;
  String meetAndGreetStatus;

  bool showInitial;
  @override
  void initState() {
    gate.neighbours = [c1];
    c1.neighbours = [c13, c2];
    c2.neighbours = [c1, c3];
    c3.neighbours = [c2, c4];
    c4.neighbours = [c3, c5];
    c5.neighbours = [c4, c6];
    c6.neighbours = [c5, c7];
    c7.neighbours = [c6, c8];
    c8.neighbours = [c9, c14, c7];
    c9.neighbours = [c10, c8];
    c10.neighbours = [c11, c9];
    c11.neighbours = [c12, c10];
    c12.neighbours = [c13, c11];
    c13.neighbours = [c12, c16, c1];
    c14.neighbours = [c8, c15];
    c15.neighbours = [c14, c16];
    c16.neighbours = [c13, c15];
    campsite = [
      gate,
      c1,
      c2,
      c3,
      c4,
      c5,
      c6,
      c7,
      c8,
      c9,
      c10,
      c11,
      c12,
      c13,
      c14,
      c15,
      c16
    ];
    initializedCamp = initializeGraph(campsite);
    report = new List();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => SettingsPage(groups: Helper().testGroup,)));
              },
              splashColor: Colors.white,
              child: Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ),
          )
        ],
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text(
              "Welcome to Lost Angeles",
              style: TextStyle(color: Colors.white),
            ),
          ),
          RaisedButton(
            shape: StadiumBorder(),
            color: Colors.white,
            onPressed: () {
               report =  meetAndGreet(widget.groups, campsite);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ReportPage(
                              report: report,
                            )));
            },
            child: Text(
              "Meet & Greet",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      )),
    );
  }

  List<Node> initializeGraph(List<Node> campsite) {
    gate.distance = 0;
    int journeyTime;
    Queue<Node> journeyPath = new Queue();
    journeyPath.add(gate);
    while (journeyPath.isNotEmpty) {
      Node currentCartLocation = journeyPath.removeFirst();
      currentCartLocation.neighbours.forEach((Node caravan) {
        if (caravan.distance == double.infinity) {
          journeyPath.add(caravan);
          caravan.distance = currentCartLocation.distance + 1;
          caravan.predecessor = caravan.predecessor + currentCartLocation.id;
        }
      });
    }
    return campsite;
  }

  double getJourneyTime(Node destinationCaravan, List<Node> campsite) {
    double time;
    for (Node caravan in campsite) {
      if (caravan.id == destinationCaravan.id) {
        time = caravan.distance;
      }
    }
//    print("Journey time: "+time.toString()+" mins");
    return time;
  }

  String getShortestRoute(Node destinationNode, List<Node> campsite) {
    String shortestRoute = "";
    Node currentNode = destinationNode;
    shortestRoute = currentNode.predecessor + " - " + currentNode.id;
    while (currentNode.predecessor != "0") {
      currentNode = campsite.firstWhere((c) => c.id == currentNode.predecessor);

      if (currentNode.predecessor == "0") {
        shortestRoute = "GATE" + " - " + shortestRoute;
      } else {
        shortestRoute = currentNode.predecessor + " - " + shortestRoute;
      }
    }
    return shortestRoute;
  }

  List<ReportItem> meetAndGreet(List<dynamic> groups, List<Node> campsite) {
    double waitingTime = 0;
    List<ReportItem> report = new List();
    for (Map<String, dynamic> group in groups) {
      String shortestRoute = "";
      Node destinationCaravan =
          campsite.firstWhere((c) => c.id == group['caravan'].toString());
      shortestRoute = getShortestRoute(destinationCaravan, campsite);
      waitingTime = waitingTime + getJourneyTime(destinationCaravan, campsite);
      print("Group: " + group['familyid'].toString());
      print("Route: " + shortestRoute);
      print("Waiting time: " + waitingTime.toInt().toString());
      print("====================");
        report.add(ReportItem(
            waitingTime: waitingTime.toInt(),
            groupId: group['familyid'].toString(),
            route: shortestRoute,
            destinationCaravan: destinationCaravan.id));

    }
    return report;
  }
}
