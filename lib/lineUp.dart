import 'dart:convert';

import 'package:flutter/material.dart';

import 'lineUp/acts.dart';
import 'lineUp/timeTable.dart';

class LineUpPage extends StatefulWidget {
  final String title;

  const LineUpPage({super.key, required this.title});

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
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Line Up"),
            bottom: const TabBar(
              tabs: [
                Tab(text: "Acts"),
                Tab(text: "Friday"),
                Tab(text: "Saturday")
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Center(
                // Use future builder and DefaultAssetBundle to load the local JSON file
                child: FutureBuilder(
                    future: DefaultAssetBundle.of(context)
                        .loadString('assets/json/acts.json'),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return const Center(child: CircularProgressIndicator());
                        default:
                          List<Act> acts =
                              parseJosnAct(snapshot.data.toString());
                          return ActList(acts: acts);
                      }
                    }),
              ),
              Center(
                // Use future builder and DefaultAssetBundle to load the local JSON file
                child: FutureBuilder(
                    future: DefaultAssetBundle.of(context)
                        .loadString('assets/json/timeTableFriday.json'),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return const Center(child: CircularProgressIndicator());
                        default:
                          List<TimeTable> timeTable =
                              parseJosnTimeTable(snapshot.data.toString());
                          return TimeTableList(timeTable: timeTable);
                      }
                    }),
              ),
              Center(
                // Use future builder and DefaultAssetBundle to load the local JSON file
                child: FutureBuilder(
                    future: DefaultAssetBundle.of(context)
                        .loadString('assets/json/timeTableSaturday.json'),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return const Center(child: CircularProgressIndicator());
                        default:
                          List<TimeTable> timeTable =
                              parseJosnTimeTable(snapshot.data.toString());
                          return TimeTableList(timeTable: timeTable);
                      }
                    }),
              ),
            ],
          ),
        ));
  }

  List<Act> parseJosnAct(String response) {
    final parsed =
        json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed.map<Act>((json) => Act.fromJson(json)).toList();
  }

  List<TimeTable> parseJosnTimeTable(String response) {
    final parsed =
        json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed
        .map<TimeTable>((json) => TimeTable.fromJson(json))
        .toList();
  }
}
