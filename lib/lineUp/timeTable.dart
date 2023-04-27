import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:like_button/like_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

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
  final int month = DateTime.april;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
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
                label: Text('Uhrzeit'),
              ),
              DataColumn(
                label: Text('Freitag'),
              ),
              DataColumn(
                label: Text('Samstag'),
              ),
            ],
            rows: widget.timeTable
                .asMap()
                .entries
                .map((e) => DataRow(cells: [
                      DataCell(Text(e.value.time)),
                      DataCell(Text(e.value.act1)),
                      DataCell(Text(e.value.day)),
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
              DataColumn(label: Text('Uhrzeit')),
              DataColumn(label: Text('Freitag')),
              DataColumn(label: Text('Reminder')),
            ],
            rows: widget.timeTable
                .asMap()
                .entries
                .map((e) => DataRow(cells: [
                      DataCell(Text(e.value.time)),
                      DataCell(Text(e.value.act1)),
                      DataCell(
                        LikeButton(
                          isLiked: preferences?.getBool(e.value.act1),
                          likeBuilder: (bool isLiked) {
                            if (isLiked) {
                              if (DateTime.now().isAfter(DateTime(
                                      year,
                                      month,
                                      int.parse(e.value.day),
                                      int.parse(e.value.time.split(':').first),
                                      int.parse(e.value.time.split(':').last))
                                  .subtract(const Duration(minutes: 15)))) {
                                if (preferences != null) {
                                  preferences!.remove(e.value.act1);
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
                                return Icon(
                                  Icons.favorite,
                                  color: Colors.grey,
                                );
                              }
                              preferences?.setBool(e.value.act1, true);
                              _zonedScheduleNotification(e.value, e.key);
                            } else {
                              flutterLocalNotificationsPlugin.cancel(e.key);
                            }
                            return Icon(
                              Icons.favorite,
                              color: isLiked ? Colors.red : Colors.grey,
                            );
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

  Future<void> _zonedScheduleNotification(
      TimeTable timeTable, int index) async {
    print(tz.TZDateTime.from(
            DateTime(
                year,
                month,
                int.parse(timeTable.day),
                int.parse(timeTable.time.split(':').first).round(),
                // convert offset in milli seconds to offset in hours
                int.parse(timeTable.time.split(':').last)),
            tz.local)
        .subtract(const Duration(minutes: 15)));
    await flutterLocalNotificationsPlugin.zonedSchedule(
        index,
        'Reminder for ${timeTable.act1}',
        '${timeTable.act1} starts his performance in 15 minutes',
        tz.TZDateTime.from(
                DateTime(
                    year,
                    month,
                    int.parse(timeTable.day),
                    int.parse(timeTable.time.split(':').first).round(),
                    // convert offset in milli seconds to offset in hours
                    int.parse(timeTable.time.split(':').last)),
                tz.local)
            .subtract(const Duration(minutes: 15)),
        NotificationDetails(
            android: AndroidNotificationDetails('$index', 'Eine Liebe',
                channelDescription: 'Reminder for acts')),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }
}
