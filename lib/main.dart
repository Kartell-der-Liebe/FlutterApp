import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/food.dart';
import 'package:flutter_app/googleMaps.dart';
import 'package:flutter_app/lineUp.dart';
import 'package:flutter_app/rss_reader.dart';
import 'package:flutter_app/utility.dart';


import 'information.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eine Liebe',
      theme: ThemeData(
        fontFamily: "EineLiebe",
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: MyColors.eineLiebeDunkelMaterialApp,
        indicatorColor: MyColors.eineLiebeHellMaterialApp,

        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Home Page'),
      initialRoute: '/',
      routes: {
        '/LineUp': (context) => LineUpPage(title: '',)
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: ListView(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          children: <Widget>[
            GestureDetector(
              child: Container(
                constraints: new BoxConstraints.expand(
                  height: 200,
                ),
                padding: new EdgeInsets.only(left: 16.0, bottom: 8.0, right: 16.0),
                margin: new EdgeInsets.only(bottom: 4),
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage('assets/images/lineup_pic_1.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: new Stack(
                  children: <Widget>[
                    new Center(
                      child: new Text('Line Up',
                          style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40.0,
                            color: MyColors.eineLiebeDunkel
                          )
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                //Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext) => LineUpPage(title: 'Line Up')));
              },
            ),
            GestureDetector(
              child: Container(
                constraints: new BoxConstraints.expand(
                  height: 200.0,
                ),
                padding: new EdgeInsets.only(left: 16.0, bottom: 8.0, right: 16.0),
                margin: new EdgeInsets.only(bottom: 4),
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage('assets/images/food_pic_3.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: new Stack(
                  children: <Widget>[
                    new Center(
                      child: new Text('Food',
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40.0,
                              color: MyColors.eineLiebeDunkel
                          )
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                //Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext) => FoodPage(title: 'Food')));
              },
            ),
            GestureDetector(
              child: Container(
                constraints: new BoxConstraints.expand(
                  height: 200.0,
                ),
                padding: new EdgeInsets.only(left: 16.0, bottom: 8.0, right: 16.0),
                margin: new EdgeInsets.only(bottom: 4),
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage('assets/images/news_pic_1.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: new Stack(
                  children: <Widget>[
                    new Center(
                      child: new Text('News',
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40.0,
                              color: MyColors.eineLiebeDunkel
                          )
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                //Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext) => NewsPage(title: 'News')));
              },
            ),
            GestureDetector(
              child: Container(
                constraints: new BoxConstraints.expand(
                  height: 200.0,
                ),
                padding: new EdgeInsets.only(left: 16.0, bottom: 8.0, right: 16.0),
                margin: new EdgeInsets.only(bottom: 4),
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage('assets/images/info_pic_1.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: new Stack(
                  children: <Widget>[
                    new Center(
                      child: new Text('Festival Information',
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40.0,
                            color: MyColors.eineLiebeDunkel,
                          )
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                //Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext) => InformationPage(title: 'Festival Information')));
              },
            ),
          ],
        ),
      ),
      drawer:
      Drawer(
        child: ListView(
            children: <Widget>[
              Container(
                decoration: new BoxDecoration(
                  color:Color(0x0FF002C3C),
                  gradient: LinearGradient(
                      colors: [
                        Color(0x0FF002C3C),
                        Color(0xFFFDEA04)
                      ],
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft
                    ),
                ),
                child:DrawerHeader(
                  child: Image.asset("assets/images/el_herz.png",),
                ),
              ),
              ListTile(
                title: Text("Line Up"),
                leading: Icon(Icons.queue_music),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext) => LineUpPage(title: 'Line Up')));
                },
              ),
              ListTile(
                title: Text("Food"),
                leading: Icon(Icons.fastfood),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext) => FoodPage(title: 'Food')));
                },
              ),
              ListTile(
                title: Text("Festival Information"),
                leading: Icon(Icons.info),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext) => InformationPage(title: "Festival Information")));
                },
              ),
              ListTile(
                leading: Icon(Icons.fiber_new),
                title: Text("News"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext) => NewsPage(title: '',)));
                },
              ),
            ],
          ),
        ),// This trailing comma makes auto-formatting nicer for build methods.
      );
  }
}


