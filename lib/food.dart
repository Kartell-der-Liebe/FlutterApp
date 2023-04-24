import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class FoodPage extends StatelessWidget {
  final String title;

  FoodPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Line Up"),
            bottom: const TabBar(
              tabs: [
                Tab(text: "Foodtruck"),
                Tab(text: "Food Sharing"),
                Tab(text: "Dorfladen")
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Center(
                // Use future builder and DefaultAssetBundle to load the local JSON file
                child: FutureBuilder(
                    future: DefaultAssetBundle.of(context)
                        .loadString('assets/json/food.json'),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return const Center(child: CircularProgressIndicator());
                          break;
                        default:
                          List<Food> food =
                              parseJosnAct(snapshot.data.toString());
                          return FoodList(food: food);
                      }
                    }),
              ),
              Container(
                margin: const EdgeInsets.all(16),
                child: ListView(
                  children: [
                    Image.asset("assets/images/foodsharing_pic.png"),
                    const Text(
                        "\nFoodsharing Sigmaringen setzt sich in der Region gegen die Verschwendung von Lebensmitteln ein und \"rettet\" Lebensmittel, die sonst weggeworfen werden würden.\n\nDie Lebensmittel werden durch #Fairteiler, also öffentliche Regale in die Lebensmittel eingestellt und herausgenommen werden können, allen Menschen zum Verzehr zugänglich gemacht.\n\nDie Mädels und Jungs von Foodsharing Sigmaringen arbeiten ehrenamtlich und möchte auch keine Geldspenden. Es geht hierbei ausschließlich um den nachhaltigen Umgang mit Lebensmitteln.\n\nWir von EINE LIEBE unterstützen diese Initiative auf ganzer Länge ❤ Deshalb werdet Ihr bei EINE LIEBE 2019 auch einen #Fairteiler nutzen können, um Lebensmitteln eine zweite Chance zu geben.\n\nFoodsharing Sigmaringen freut sich unheimlich darüber, wenn Ihr am #Fairteiler vorbeischaut. Sei es um etwas zu geben, etwas zu nehmen oder einfach zu quatschen.")
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(16),
                child: ListView(
                  children: [
                    Image.asset("assets/images/dorfladen_pic.png"),
                    const Text(
                        "\nDeine \"besten\" Freunde haben Dir mal wieder das letzte Dosenbier weggeschnappt?\n\nBis gestern warst Du Vegetarier und hast deshalb zum Grillen nur eine Ananas dabei?\n\nDu kannst den fleischigen Gelüsten widerstehen, jedoch ist sämtliches Obst und Gemüse schon weggefuttert?\n\nNULL PROBLEMO 😉\n\nFür diese und auch alle anderen alltäglichen Festival-Problemen gibt es nämlich den Dorfladen Rokweiler im Herzen von Herdwangen. Das ganze Jahr über versorgt er mit regionalen Produkten und großer Vielfalt zu fairen Preisen die Umgebung.\n\nWährend EINE LIEBE lassen sich die Macher natürlich nicht lumpen und bieten in ihrer extra eingerichteten Festival-Abteilung alles an, was das Camperherz begehrt: Grillgut, Einweggrills, Dosenbier, Zigaretten, Hygieneartikel, Regencapes und vieles mehr.\n\nFür die Spontanen unter Euch hat der Dorfladen sowohl am Samstag als auch am Sonntag tagsüber geöffnet! Und das in nur 10 Fußminuten Entfernung.\n\nZusätzlich zur Einkaufsmöglichkeit bereiten Euch die Damen und Herren vom Dorfladen am Samstag- und Sonntagmorgen in der Zeit von 09.00 bis 12.00 Uhr beim Einlass zum Camping-Platz ein leckeres Frühstück. Denn ihr wisst ja - ein vollwertiges Frühstück ist unabdingbar für einen gesunden Start in den Tag.\n\nDas Team des Dorfladens Rokweiler freut sich auf Euch!")
                  ],
                ),
              )
            ],
          ),
        ));
  }

  List<Food> parseJosnAct(String response) {
    if (response == null) {
      return [];
    }
    final parsed =
        json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed.map<Food>((json) => new Food.fromJson(json)).toList();
  }
}

class Food {
  final String name;
  final String image;
  final String link;

  Food({required this.name, required this.image, required this.link});

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
        name: json['name'] as String,
        image: json['image'] as String,
        link: json['link'] as String);
  }
}

class FoodList extends StatelessWidget {
  final List<Food> food;

  FoodList({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: food.length,
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
                image: AssetImage(food[index].image),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: <Widget>[
                Center(
                  child: Text(food[index].name,
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
