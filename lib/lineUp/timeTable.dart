import 'package:flutter/material.dart';
import 'package:flutter_app/lineUp/acts.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:like_button/like_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class TimeTableActs {
  final String time;
  final String name;
  final String day;

  TimeTableActs({required this.time, required this.name, required this.day});

  factory TimeTableActs.fromJson(Map<String, dynamic> json) {
    return TimeTableActs(
      time: json['time'] as String,
      name: json['name'] as String,
      day: json['day'] as String,
    );
  }
}

class TimeTable {
  final String stage;
  final List<TimeTableActs> acts;

  TimeTable({required this.stage, required this.acts});

  factory TimeTable.fromJson(dynamic json) {
    var actObjsJson = json['acts'] as List;
    List<TimeTableActs> temp2 =
        actObjsJson.map((actJson) => TimeTableActs.fromJson(actJson)).toList();
    return TimeTable(stage: json['stage'] as String, acts: temp2);
  }
}

class TimeTableList extends StatefulWidget {
  final List<TimeTable> timeTable;

  TimeTableList({key, required this.timeTable});

  @override
  State<TimeTableList> createState() => TimeTableListState();
}

class TimeTableListState extends State<TimeTableList> {
  final Future<SharedPreferences> sharedPrefsFuture =
      SharedPreferences.getInstance();
  SharedPreferences? preferences;
  final int year = 2023;
  final int month = DateTime.august;
  final InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('app_icon'));

  @override
  void initState() {
    super.initState();
    initializePreference().whenComplete(() {
      setState(() {});
    });
  }

  Future<void> initializePreference() async {
    this.preferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    initializeTime();
    return Container(
      child: ListView(children: [
        Text("Main Stage", textScaleFactor: 2, textAlign: TextAlign.center),
        DataTable(
            headingRowColor: MaterialStateProperty.all(Colors.black26),
            columns: const <DataColumn>[
              DataColumn(
                label: Text('Time'),
              ),
              DataColumn(
                label: Text('Friday'),
              ),
              DataColumn(
                label: Text('Reminder'),
              ),
            ],
            rows: widget.timeTable
                .elementAt(0)
                .acts
                .asMap()
                .entries
                .map((e) => DataRow(cells: [
                      DataCell(Text(e.value.time)),
                      DataCell(Text(e.value.name)),
                      DataCell(
                        LikeButton(
                          isLiked: preferences?.getBool(e.value.name) == null ||
                                  preferences?.getBool(e.value.name) == false
                              ? false
                              : true,
                          onTap: (bool isLiked) async {
                            if (!isLiked) {
                              if (DateTime.now().isAfter(DateTime(
                                      year,
                                      month,
                                      int.parse(e.value.day),
                                      int.parse(e.value.time.split(':').first),
                                      int.parse(e.value.time.split(':').last))
                                  .subtract(const Duration(minutes: 15)))) {
                                if (preferences != null) {
                                  preferences!.remove(e.value.name);
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Time for reminder is in the past",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.redAccent,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                                return false;
                              }
                              preferences?.setBool(e.value.name, true);
                              _zonedScheduleNotification(e.value, e.key);
                            } else {
                              preferences?.setBool(e.value.name, false);
                              flutterLocalNotificationsPlugin.cancel(e.key);
                            }
                            return !isLiked;
                          },
                        ),
                      )
                    ]))
                .toList()),
        Text(
          "DJ Floor",
          textScaleFactor: 2,
          textAlign: TextAlign.center,
        ),
        DataTable(
            headingRowColor: MaterialStateProperty.all(Colors.black26),
            columns: const <DataColumn>[
              DataColumn(label: Text('Time')),
              DataColumn(label: Text('Saturday')),
              DataColumn(label: Text('Reminder')),
            ],
            rows: widget.timeTable
                .elementAt(1)
                .acts
                .asMap()
                .entries
                .map((e) => DataRow(cells: [
                      DataCell(Text(e.value.time)),
                      DataCell(Text(e.value.name)),
                      DataCell(
                        LikeButton(
                          isLiked: preferences?.getBool(e.value.name) == null ||
                                  preferences?.getBool(e.value.name) == false
                              ? false
                              : true,
                          onTap: (bool isLiked) async {
                            if (!isLiked) {
                              if (DateTime.now().isAfter(DateTime(
                                      year,
                                      month,
                                      int.parse(e.value.day),
                                      int.parse(e.value.time.split(':').first),
                                      int.parse(e.value.time.split(':').last))
                                  .subtract(const Duration(minutes: 15)))) {
                                if (preferences != null) {
                                  preferences!.remove(e.value.name);
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Time for reminder is in the past",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.redAccent,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                                return false;
                              }
                              preferences?.setBool(e.value.name, true);
                              _zonedScheduleNotification(e.value, e.key);
                            } else {
                              preferences?.setBool(e.value.name, false);
                              flutterLocalNotificationsPlugin.cancel(e.key);
                            }
                            return !isLiked;
                          },
                        ),
                      )
                    ]))
                .toList()),
      ]),
    );
  }

  Future<void> initializeTime() async {
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName.toString()));
  }

  Future<void> _zonedScheduleNotification(TimeTableActs act, int index) async {
    DateTime timer = DateTime(
            year,
            month,
            int.parse(act.day),
            int.parse(act.time.split(':').first).round(),
            // convert offset in milli seconds to offset in hours
            int.parse(act.time.split(':').last))
        .subtract(const Duration(minutes: 15));
    Fluttertoast.showToast(
        msg: "Time for ${act.name} set at $timer",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Erinnerung für einen Auftritt',
        '${act.name} tritt in 15 Minuten auf',
        tz.TZDateTime(
                tz.local,
                year,
                month,
                int.parse(act.day),
                int.parse(act.time.split(':').first).round(),
                // convert offset in milli seconds to offset in hours
                int.parse(act.time.split(':').last))
            .subtract(const Duration(minutes: 15)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                '0', 'Act reminder',
                icon: 'app_icon',
                importance: Importance.max,
                priority: Priority.high)),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
