import 'dart:convert';

import 'package:flutter/material.dart';

import 'lineUp/acts.dart';
import 'lineUp/timeTable.dart';

class LineUpPage extends StatefulWidget {
  final String title;

  LineUpPage({super.key, required this.title});

  @override
  LineUpPageState createState() => LineUpPageState();
}

class LineUpPageState extends State<LineUpPage> {
  //Calendar Variables
  bool deleted = false;
  bool calendarSelected = false;
  String calendarButtonText = 'Select Calendar to Add Events';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: new Scaffold(
          appBar: new AppBar(
            title: Text("Line Up"),
            bottom: TabBar(
              tabs: [
                new Tab(text: "Acts"),
                new Tab(text: "Friday"),
                new Tab(text: "Saturday")
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Container(
                child: new Center(
                  // Use future builder and DefaultAssetBundle to load the local JSON file
                  child: new FutureBuilder(
                      future: DefaultAssetBundle.of(context)
                          .loadString('assets/json/acts.json'),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return Center(child: CircularProgressIndicator());
                          default:
                            List<Act> acts =
                                parseJosnAct(snapshot.data.toString());
                            return new ActList(acts: acts);
                        }
                      }),
                ),
              ),
              Container(
                child: new Center(
                  // Use future builder and DefaultAssetBundle to load the local JSON file
                  child: new FutureBuilder(
                      future: DefaultAssetBundle.of(context)
                          .loadString('assets/json/timeTableFriday.json'),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return Center(child: CircularProgressIndicator());
                          default:
                            List<TimeTable> timeTable =
                                parseJosnTimeTable(snapshot.data.toString());
                            return new TimeTableList(timeTable: timeTable);
                        }
                      }),
                ),
              ),
              Container(
                child: new Center(
                  // Use future builder and DefaultAssetBundle to load the local JSON file
                  child: new FutureBuilder(
                      future: DefaultAssetBundle.of(context)
                          .loadString('assets/json/timeTableSaturday.json'),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return Center(child: CircularProgressIndicator());
                          default:
                            List<TimeTable> timeTable =
                                parseJosnTimeTable(snapshot.data.toString());
                            return new TimeTableList(timeTable: timeTable);
                        }
                      }),
                ),
              ),
            ],
          ),
        ));
  }

  List<Act> parseJosnAct(String response) {
    final parsed =
        json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed.map<Act>((json) => new Act.fromJson(json)).toList();
  }

  List<TimeTable> parseJosnTimeTable(String response) {
    final parsed =
        json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed
        .map<TimeTable>((json) => new TimeTable.fromJson(json))
        .toList();
  }
}
