import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:like_button/like_button.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

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
  String _currentCalendarID = '';
  DeviceCalendarPlugin _deviceCalendarPlugin = new DeviceCalendarPlugin();

  bool? _setCalendarCallback(
      String calendarID, String calendarName, DeviceCalendarPlugin deviceCal) {
    //Calendar Callback Function used by Calendar Page
    //Calendar Page will call the callback to provide calendar info needed
    //to load mma events into calendar
    setState(() {
      _currentCalendarID = calendarID;
      calendarButtonText = calendarName;
      _deviceCalendarPlugin = deviceCal;
      calendarSelected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: new Scaffold(
          appBar: new AppBar(
            title: Text("Line Up"),
            bottom: TabBar(
              tabs: [
                new Tab(text: "Acts"),
                new Tab(
                  text: "Time Table",
                ),
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
                            break;
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
                          .loadString('assets/json/timeTable.json'),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return Center(child: CircularProgressIndicator());
                            break;
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
    if (response == null) {
      return [];
    }
    final parsed =
        json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed.map<Act>((json) => new Act.fromJson(json)).toList();
  }

  List<TimeTable> parseJosnTimeTable(String response) {
    if (response == null) {
      return [];
    }
    final parsed =
        json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed
        .map<TimeTable>((json) => new TimeTable.fromJson(json))
        .toList();
  }
}

class Act {
  final String name;
  final String time;
  final String stage;
  final String duration;
  final String day;
  final String image;

  Act(
      {required this.name,
      required this.time,
      required this.stage,
      required this.duration,
      required this.day,
      required this.image});

  factory Act.fromJson(Map<String, dynamic> json) {
    return Act(
        name: json['name'] as String,
        time: json['time'] as String,
        stage: json['stage'] as String,
        duration: json['duration'] as String,
        day: json['day'] as String,
        image: json['image'] as String);
  }
}

class ActList extends StatelessWidget {
  final List<Act> acts;

  ActList({super.key, required this.acts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: acts.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              child: new Container(
            constraints: new BoxConstraints.expand(
              height: 200.0,
            ),
            padding: new EdgeInsets.only(left: 16.0, bottom: 8.0, right: 16.0),
            margin: new EdgeInsets.only(bottom: 4),
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage(acts[index].image),
                fit: BoxFit.cover,
              ),
            ),
            child: new Stack(
              children: <Widget>[
                new Center(
                  child: new Text(acts[index].name,
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      )),
                ),
                GestureDetector(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                        child: Image.asset(
                      'assets/images/calendar_icon_kartell.png',
                      height: 60,
                    )),
                  ),
                ),
              ],
            ),
          ));
        });
  }
}

class TimeTable {
  final String time;
  final String act1;
  final String day;

  TimeTable({required this.time, required this.act1, required this.day});

  factory TimeTable.fromJson(Map<String, dynamic> json) {
    return TimeTable(
      time: json['time'] as String,
      act1: json['act1'] as String,
      day: json['day'] as String,
    );
  }
}

class TimeTableList extends StatelessWidget {
  final List<TimeTable> timeTable;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('app_icon'));

  TimeTableList({key, required this.timeTable});

  @override
  Widget build(BuildContext context) {
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    return Container(
      child: ListView(children: [
        Text("Main Stage", textScaleFactor: 2, textAlign: TextAlign.center),
        DataTable(
            headingRowColor: MaterialStateProperty.all(Colors.black26),
            columns: const <DataColumn>[
              DataColumn(
                label: Text('Uhrzeit'),
              ),
              DataColumn(
                label: Text('Freitag'),
              ),
              DataColumn(
                label: Text('Samstag'),
              ),
            ],
            rows: timeTable
                .map((e) => DataRow(cells: [
                      DataCell(Text(e.time)),
                      DataCell(Text(e.act1)),
                      DataCell(Text(e.day)),
                    ]))
                .toList()),
        Text(
          "DJ Zelt",
          textScaleFactor: 2,
          textAlign: TextAlign.center,
        ),
        DataTable(
            headingRowColor: MaterialStateProperty.all(Colors.black26),
            columns: const <DataColumn>[
              DataColumn(
                label: Text('Uhrzeit'),
              ),
              DataColumn(
                label: Text('Freitag'),
              ),
              DataColumn(label: Icon(Icons.timer)),
            ],
            rows: timeTable
                .map((e) => DataRow(cells: [
                      DataCell(Text(e.time)),
                      DataCell(Text(e.act1)),
                      DataCell(LikeButton(
                        likeBuilder: (bool isLiked) {
                          if (isLiked) {
                            _zonedScheduleNotification(e);
                          }
                          return Icon(
                            Icons.favorite,
                            color: isLiked ? Colors.red : Colors.grey,
                          );
                        },
                      ))
                    ]))
                .toList()),
      ]),
    );
  }

  Future<void> _zonedScheduleNotification(TimeTable timeTable) async {
    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
    print(tz.TZDateTime.from(
        DateTime.utc(
            2023,
            4,
            int.parse(timeTable.day),
            int.parse(timeTable.time.split(':').first) - 2,
            int.parse(timeTable.time.split(':').last)), tz.local)
        .subtract(const Duration(minutes: 15)));
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        timeTable.act1,
        timeTable.day,
        tz.TZDateTime.from(
                DateTime.utc(
                    2023,
                    4,
                    int.parse(timeTable.day),
                    int.parse(timeTable.time.split(':').first) - 2,
                    int.parse(timeTable.time.split(':').last)),
                tz.local)
            .subtract(const Duration(minutes: 15)),
        const NotificationDetails(
            android: AndroidNotificationDetails('0', 'test',
                channelDescription: 'your channel description')),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }
}
