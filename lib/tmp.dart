import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_app/lineUp.dart';
import 'package:flutter_app/utility.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_app/success_screen.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class TMPApp extends StatefulWidget {
  final Act? act;

  TMPApp({Key? key, this.act}) : super(key: key);
  @override
  _MyAppState createState() => new _MyAppState(act: this.act);
}

class _MyAppState extends State<TMPApp> {
  final Act? act;

  _MyAppState({this.act});
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  initState() {
    super.initState();
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    // If you have skipped STEP 3 then change app_icon to @mipmap/ic_launcher
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new DarwinInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onSelectNotification);
    _requestPermissions();
  }

  void _requestPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Errinerung für ${act!.name}"),
      ),
      body: new Center(
          child: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(16),
            child: Text(
              act!.name!,
              textScaleFactor: 3,
              textAlign: TextAlign.center,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                  width: 220,
                  height: 70,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: MyColors.eineLiebeDunkel,
                      shape: StadiumBorder(),
                    ),
                    onPressed: () {
                      _zonedScheduleNotification(act);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return SuccessScreen();
                          },
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        "Confirm",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  )),
              Container(
                  width: 220,
                  height: 70,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: MyColors.eineLiebeDunkel,
                      shape: StadiumBorder(),
                    ),
                    onPressed: () {
                      _checkPendingNotificationRequests();
                    },
                    child: Center(
                      child: Text(
                        "Test",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ],
      )),
    );
  }

  void onSelectNotification(NotificationResponse notificationResponse) {
    showDialog(
      context: context,
      builder: (_) {
        return new AlertDialog(
          title: Text("PayLoad"),
          content: Text("Payload : " + notificationResponse.payload!),
        );
      },
    );
  }

  Future _showNotificationWithoutSound() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      playSound: false,
      importance: Importance.max,
      priority: Priority.high,
    );
    var iOSPlatformChannelSpecifics =
        new DarwinNotificationDetails(presentSound: false);
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'New Post',
      'How to Show Notification in Flutter',
      platformChannelSpecifics,
      payload: 'No_Sound',
    );
  }

  Future _showNotificationWithDefaultSound() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
    );
    var iOSPlatformChannelSpecifics = new DarwinNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'New Post',
      'How to Show Notification in Flutter',
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  Future<void> _showNotificationCustomVibrationIconLed() async {
    final Int64List vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;

    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'other custom channel id',
      'other custom channel name',
      channelDescription: 'other custom channel description',
      icon: 'app_icon',
      largeIcon: const DrawableResourceAndroidBitmap('app_icon'),
      vibrationPattern: vibrationPattern,
      enableLights: true,
      color: const Color.fromARGB(255, 255, 0, 0),
      ledColor: const Color.fromARGB(255, 255, 0, 0),
      ledOnMs: 1000,
      ledOffMs: 500,
    );

    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0,
        'title of notification with custom vibration pattern, LED and icon',
        'body of notification with custom vibration pattern, LED and icon',
        platformChannelSpecifics);
  }

  Future<void> _zonedScheduleNotification(Act? act) async {
    _configureLocalTimeZone();
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'scheduled title',
        'scheduled body',
        tz.TZDateTime(
            tz.local,
            tz.TZDateTime.now(tz.local).year,
            tz.TZDateTime.now(tz.local).month,
            tz.TZDateTime.now(tz.local).day,
            tz.TZDateTime.now(tz.local).hour,
            tz.TZDateTime.now(tz.local).minute,
            tz.TZDateTime.now(tz.local).second + 5),
        const NotificationDetails(
            android: AndroidNotificationDetails(
          'your channel id',
          'your channel name',
          channelDescription: 'your channel description',
          icon: 'app_icon',
          importance: Importance.max,
          priority: Priority.high,
        )),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = "Europe/London";
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'plain title', 'plain body', platformChannelSpecifics,
        payload: 'item x');
  }

  Future<void> _checkPendingNotificationRequests() async {
    final List<PendingNotificationRequest> pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content:
            Text('${pendingNotificationRequests.length} pending notification '
                'requests'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
