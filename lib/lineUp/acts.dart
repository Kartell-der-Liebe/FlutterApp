import 'package:flutter/material.dart';

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
              ],
            ),
          ));
        });
  }
}
