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

  const ActList({super.key, required this.acts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: acts.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              child: Container(
            constraints: const BoxConstraints.expand(
              height: 200.0,
            ),
            padding: const EdgeInsets.only(left: 16.0, bottom: 8.0, right: 16.0),
            margin: const EdgeInsets.only(bottom: 4),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(acts[index].image),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: <Widget>[
                Center(
                  child: Text(acts[index].name,
                      style: const TextStyle(
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
