import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/calender/calender.dart';
import 'package:flutter_app/calender/calenderStart.dart';
import 'package:flutter_app/tmp.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:device_calendar/device_calendar.dart';

class AppRoutes {
  static final calendars = "/";
}


class LineUpPage extends StatefulWidget {
  final String title;

  LineUpPage({Key key, this.title}) : super(key: key);


  @override
  LineUpPageState createState() => LineUpPageState();
}

class LineUpPageState extends State<LineUpPage>{

  //Calendar Variables
  bool deleted = false;
  bool calendarSelected = false;
  String calendarButtonText = 'Select Calendar to Add Events';
  String _currentCalendarID = '';
  DeviceCalendarPlugin _deviceCalendarPlugin = new DeviceCalendarPlugin();

  bool _setCalendarCallback(
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
                new Tab(text: "Time Table",),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Container(
                child: new Center(
                  // Use future builder and DefaultAssetBundle to load the local JSON file
                  child: new FutureBuilder(
                    future: DefaultAssetBundle.of(context).loadString('assets/json/acts.json'),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return Center(child: CircularProgressIndicator());
                          break;
                        default:
                          List<Act> acts = parseJosnAct(snapshot.data.toString());
                          return new ActList(acts: acts);
                      }
                    }
                  ),
                ),
              ),
              Container(
                child: new Center(
                  // Use future builder and DefaultAssetBundle to load the local JSON file
                  child: new FutureBuilder(
                      future: DefaultAssetBundle.of(context).loadString('assets/json/timeTable.json'),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return Center(child: CircularProgressIndicator());
                            break;
                          default:
                            List<TimeTable> timeTable = parseJosnTimeTable(snapshot.data.toString());
                            return new TimeTableList(timeTable: timeTable);
                        }
                      }
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }

  List<Act> parseJosnAct(String response) {
    if(response==null){
      return [];
    }
    final parsed = json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed.map<Act>((json) => new Act.fromJson(json)).toList();
  }

  List<TimeTable> parseJosnTimeTable(String response) {
    if(response==null){
      return [];
    }
    final parsed = json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed.map<TimeTable>((json) => new TimeTable.fromJson(json)).toList();
  }
}

class Act{
  final String name;
  final String time;
  final String stage;
  final String duration;
  final String day;
  final String image;

  Act({this.name, this.time, this.stage, this.duration, this.day, this.image});

  factory Act.fromJson(Map<String, dynamic> json){
    return Act(
        name: json['name'] as String,
        time: json['time'] as String,
        stage: json['stage'] as String,
        duration: json['duration'] as String,
        day: json['day'] as String,
        image: json['image'] as String
    );
  }
}

class ActList extends StatelessWidget {
  final List<Act> acts;
  Function callback;
  ActList({Key key, this.acts, this.callback}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: acts == null ? 0 : acts.length,
        itemBuilder: (BuildContext context, int index) {
          return
            new Card(
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
                      child: new Text(acts[index].name,style: new TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,)
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                            child: Image.asset('assets/images/calendar_icon_kartell.png',height: 60,
                            )
                        ),
                      ),
                      onTap: (){

                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext) => TMPApp(act: acts[index])));

                      },
                    ),
                  ],
                ),
              )
            );
        }
    );
  }
}

class TimeTable{
  final String time;
  final String act1;
  final String act2;

  TimeTable({this.time, this.act1, this.act2});

  factory TimeTable.fromJson(Map<String, dynamic> json){
    return TimeTable(
        time: json['time'] as String,
        act1: json['act1'] as String,
        act2: json['act2'] as String,
    );
  }
}

class TimeTableList extends StatelessWidget{
  final List<TimeTable> timeTable;
  TimeTableList({Key key, this.timeTable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
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
              rows: timeTable.map((e) => DataRow(cells: [
                DataCell(Text(e.time)),
                DataCell(Text(e.act1)),
                DataCell(Text(e.act2)),
              ])
              ).toList()
          ),
          Text("DJ Zelt", textScaleFactor: 2, textAlign: TextAlign.center,),
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
              rows: timeTable.map((e) => DataRow(cells: [
                DataCell(Text(e.time)),
                DataCell(Text(e.act1)),
                DataCell(Text(e.act2)),
              ])
              ).toList()
          ),
        ]
      ),
    );
  }
}