import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

import 'googleMaps.dart';

class InformationPage extends StatefulWidget {
  InformationPage({Key? key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String? title;

  @override
  InformationPageState createState() => InformationPageState();
}

class InformationPageState extends State<InformationPage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new DefaultTabController(
      length: 4,
      child: new Scaffold(
        appBar: new AppBar(
          title: Text(widget.title!),
          bottom: TabBar(
                //labelColor: Colors.black,
                //unselectedLabelColor: Colors.black38,
                tabs: [
                  new Tab(text: "Info"),
                  new Tab(text: "Anreise",),
                  new Tab(text: "Camping"),
                  new Tab(text: "Unter 18",)
                ],
              ),
        ),
        body: TabBarView(
          children: [
            Container(
              margin: EdgeInsets.all(16),
              child: ListView(
                children: [
                  ExpandablePanel(
                    header: Text("Allgemeine Informationen\n", textAlign: TextAlign.center, textScaleFactor: 2),
                    collapsed: Text("Das Kartell der Liebe, entstanden aus dem No Stress-Gedanken, steht für eine Null-Toleranz-Einstellung gegenüber jedweder körperlichen oder psychischen Aggression, respektlosen Verhalten oder groben Verstößen gegen die Regeln unseres Festivals. Wir wollen zusammen mit allen Festivalbesuchern bei EINE LIEBE eine positive Atmosphäre schaffen, die sich gegen Hass, Rassismus, Sexismus, Homophobie und anderweitige Ressentiments und Ausgrenzung stellt. Auch appellieren wir an dieser Stelle an unsere Verbundenheit zur Natur: Bitte achtet auf dieses wunderschöne Fleckchen, das wir für unser Festival auserkoren haben. Macht nichts kaputt und werft vor allem keinen Müll oder Sonstiges in die Bachläufe, Wälder und Felder.\n\nUm gemeinsam ein unvergleichliches und stressfreies Festival-Wochenende zu haben, gilt während der gesamten Veranstaltung unsere Hausordnung. Die Hausordnung und das Sicherheitskonzept wurde gemeinsam mit der Polizei, der Feuerwehr, dem Sanitätsdienst, der Gemeinde Herdwangen-Schönach und dem Landratsamt erstellt, um uns allen ein friedliches und sicheres Festival zu ermöglichen.\n\nManche Dinge mögen Euch vielleicht etwas unentspannt, geradezu „kommerziell“ vorkommen, doch gibt es für diese Regeln und Vorgaben ganz bestimmte Gründe: Seit einiger Zeit merken wir alle mehr und mehr, dass die Welt eine andere geworden ist und zu Recht die wichtigste Frage lautet: „Was tut ein Veranstalter für die Sicherheit der Besucher?“ Diese Sicherheit steht für uns an erster Stelle!\n\nDas Sicherheitskonzept bedeutet jedoch leider nicht nur Konsequenzen und Zugeständnisse für uns als Organisatoren, sondern auch für Euch als Besucher. Wir haben uns nach langen Beratungen und unter Abwägung aller Optionen zusammen mit den zuständigen Behörden zu diesen Regelungen entschlossen, um diese gemeinsam mit Euch umzusetzen. Zu Beginn besonders hervorzuheben ist die Anwendung des Jugendschutzgesetzes (JuSchG), welches ihr weiter unten findet und genauso die Anwendung des Betäubungsmittelgesetzes (BtMG).", softWrap: true, maxLines: 5, overflow: TextOverflow.ellipsis),
                    expanded: Text("Das Kartell der Liebe, entstanden aus dem No Stress-Gedanken, steht für eine Null-Toleranz-Einstellung gegenüber jedweder körperlichen oder psychischen Aggression, respektlosen Verhalten oder groben Verstößen gegen die Regeln unseres Festivals. Wir wollen zusammen mit allen Festivalbesuchern bei EINE LIEBE eine positive Atmosphäre schaffen, die sich gegen Hass, Rassismus, Sexismus, Homophobie und anderweitige Ressentiments und Ausgrenzung stellt. Auch appellieren wir an dieser Stelle an unsere Verbundenheit zur Natur: Bitte achtet auf dieses wunderschöne Fleckchen, das wir für unser Festival auserkoren haben. Macht nichts kaputt und werft vor allem keinen Müll oder Sonstiges in die Bachläufe, Wälder und Felder.\n\nUm gemeinsam ein unvergleichliches und stressfreies Festival-Wochenende zu haben, gilt während der gesamten Veranstaltung unsere Hausordnung. Die Hausordnung und das Sicherheitskonzept wurde gemeinsam mit der Polizei, der Feuerwehr, dem Sanitätsdienst, der Gemeinde Herdwangen-Schönach und dem Landratsamt erstellt, um uns allen ein friedliches und sicheres Festival zu ermöglichen.\n\nManche Dinge mögen Euch vielleicht etwas unentspannt, geradezu „kommerziell“ vorkommen, doch gibt es für diese Regeln und Vorgaben ganz bestimmte Gründe: Seit einiger Zeit merken wir alle mehr und mehr, dass die Welt eine andere geworden ist und zu Recht die wichtigste Frage lautet: „Was tut ein Veranstalter für die Sicherheit der Besucher?“ Diese Sicherheit steht für uns an erster Stelle!\n\nDas Sicherheitskonzept bedeutet jedoch leider nicht nur Konsequenzen und Zugeständnisse für uns als Organisatoren, sondern auch für Euch als Besucher. Wir haben uns nach langen Beratungen und unter Abwägung aller Optionen zusammen mit den zuständigen Behörden zu diesen Regelungen entschlossen, um diese gemeinsam mit Euch umzusetzen. Zu Beginn besonders hervorzuheben ist die Anwendung des Jugendschutzgesetzes (JuSchG), welches ihr weiter unten findet und genauso die Anwendung des Betäubungsmittelgesetzes (BtMG).", softWrap: true,),
                  ),
                  Text("\n\n"),
                  ExpandablePanel(
                    header: Text("FINGER WEG VON DROGEN\n", textAlign: TextAlign.center, textScaleFactor: 2),
                    collapsed: Text("Besitz, Handel und Konsum von Betäubungsmitteln ist für alle Besucher von EINE LIEBE auf dem gesamten Camping- und Veranstaltungsgelände ausdrücklich verboten. Zuwiderhandlungen führen zum Ausschluss vom Festival sowie zur Benachrichtigung der Polizei. Bei Jugendlichen unter 18 Jahren erfolgt unverzüglich die Benachrichtigung der Erziehungsberechtigten.", softWrap: true, maxLines: 5, overflow: TextOverflow.ellipsis),
                    expanded: Text("Besitz, Handel und Konsum von Betäubungsmitteln ist für alle Besucher von EINE LIEBE auf dem gesamten Camping- und Veranstaltungsgelände ausdrücklich verboten. Zuwiderhandlungen führen zum Ausschluss vom Festival sowie zur Benachrichtigung der Polizei. Bei Jugendlichen unter 18 Jahren erfolgt unverzüglich die Benachrichtigung der Erziehungsberechtigten.", softWrap: true),
                  ),
                  Text("\n\n"),
                  ExpandablePanel(
                    header: Text("NOTFÄLLE\n", textAlign: TextAlign.center, textScaleFactor: 2),
                    collapsed: Text("Bei Verletzungen oder sonstigen Notfällen ist unser Sanitätsdienst über das gesamte Wochenende durchgehend - auch in der Nacht - für Euch da. Die genaue Position des Sanitäter-Zelts entnehmt bitte dem Geländeplan. Neben den Sanitätern ist auch unser Sicherheitsdienst durchgehend auf dem Gelände anzutreffen. Bitte zögert nicht, sobald Euch etwas komisch vorkommt, Meldung zu machen. Auch wenn Ihr Euch nicht sicher seid, dass es tatsächlich ein Notfall ist.\n\nWie überall können Notfälle zu jeder Zeit auch direkt via 110 oder 112 aufgegeben werden.", softWrap: true, maxLines: 5, overflow: TextOverflow.ellipsis),
                    expanded: Text("Bei Verletzungen oder sonstigen Notfällen ist unser Sanitätsdienst über das gesamte Wochenende durchgehend - auch in der Nacht - für Euch da. Die genaue Position des Sanitäter-Zelts entnehmt bitte dem Geländeplan. Neben den Sanitätern ist auch unser Sicherheitsdienst durchgehend auf dem Gelände anzutreffen. Bitte zögert nicht, sobald Euch etwas komisch vorkommt, Meldung zu machen. Auch wenn Ihr Euch nicht sicher seid, dass es tatsächlich ein Notfall ist.\n\nWie überall können Notfälle zu jeder Zeit auch direkt via 110 oder 112 aufgegeben werden.", softWrap: true,),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: ListView(
                children: [
                  Text("Anreise", textAlign: TextAlign.center, textScaleFactor: 2),
                  GestureDetector(
                    child: Image.asset("assets/images/googleMapsLogo.png", height: 200,),
                    onTap: (){MapUtils.openMap(47.855170, 9.178089);}
                  ),
                  ExpandablePanel(
                    header: Text("MIT DEM AUTO\n", textAlign: TextAlign.center, textScaleFactor: 1.5, ),
                    collapsed: Text("Bitte achtet im Vorfeld Eurer Anreise auf alle aktuellen Anfahrtshinweise, die wir über unsere EINE LIEBE Facebookseite und E-Mail kommunizieren. Vor Ort ist die Verkehrs- und die Festivalbeschilderung zu beachten. Von uns abgesperrte Straßen sind vor allem aus Sicherheitsgründen als Rettungswege wichtig für unser gemeinsames Festival, eine Anreise ist nur über die ausgeschilderte Zufahrt möglich. Schleichwege bringen Euch und uns gar nichts. Wir wollen Euch nicht ärgern, sondern dafür sorgen, dass Ihr schnell und sicher beim EINE LIEBE ankommt. Helft uns dabei!\n\nDie Parkplatz-Zufahrt befindet sich auf der L195 von Herdwangen in Richtung Überlingen/Owingen, ca. 800m vom Ortsausgang Vorstadt entfernt. Am besten ihr gebt in eurem Navi folgende Adresse ein und folgt von dort aus der Beschilderung:\n\nBodenseestraße\n88634 Herdwangen-Schönach\n\nAlternativ könnt ihr auch folgende Koordinaten bei GoogleMaps oder anderen Karten-Diensten eingeben:\n47.8476, 9.1717\n\nUnd für die ganz Modernen unter Euch:\n///birke.dichterin.jugendliebe",softWrap: true, maxLines: 5, overflow: TextOverflow.ellipsis),
                    expanded: Text("Bitte achtet im Vorfeld Eurer Anreise auf alle aktuellen Anfahrtshinweise, die wir über unsere EINE LIEBE Facebookseite und E-Mail kommunizieren. Vor Ort ist die Verkehrs- und die Festivalbeschilderung zu beachten. Von uns abgesperrte Straßen sind vor allem aus Sicherheitsgründen als Rettungswege wichtig für unser gemeinsames Festival, eine Anreise ist nur über die ausgeschilderte Zufahrt möglich. Schleichwege bringen Euch und uns gar nichts. Wir wollen Euch nicht ärgern, sondern dafür sorgen, dass Ihr schnell und sicher beim EINE LIEBE ankommt. Helft uns dabei!\n\nDie Parkplatz-Zufahrt befindet sich auf der L195 von Herdwangen in Richtung Überlingen/Owingen, ca. 800m vom Ortsausgang Vorstadt entfernt. Am besten ihr gebt in eurem Navi folgende Adresse ein und folgt von dort aus der Beschilderung:\n\nBodenseestraße\n88634 Herdwangen-Schönach\n\nAlternativ könnt ihr auch folgende Koordinaten bei GoogleMaps oder anderen Karten-Diensten eingeben:\n47.8476, 9.1717\n\nUnd für die ganz Modernen unter Euch:\n///birke.dichterin.jugendliebe", softWrap: true,),
                  ),
                  Text("\n\n"),
                  ExpandablePanel(
                    header: Text("UNWETTER\n", textAlign: TextAlign.center, textScaleFactor: 1.5),
                    collapsed: Text("Sollte der Parkplatz bei An- oder Abreise durch anhaltenden Regen sehr nass geworden sein, bitten wir Euch, so vorsichtig wie es geht über diese Flächen zu fahren. Bitte befolgt immer die Anweisungen unserer Einweiser und habt Geduld, sollte es wider Erwarten zu Verzögerungen bei der An- oder Abreise kommen.Wetterbedingt kann es passieren, dass sich Autos festgefahren haben. In diesem Fall tun wir unser Möglichstes, um alle Betroffenen mit einem Traktor abzuschleppen. Präpariert Euren Wagen mit dem Abschlepphaken, schaltet die Warnblinkanlage an und habt etwas Geduld, denn: wenn es wirklich nass ist, muss bei jedem Abschleppen behutsam vorgegangen werden. Wir können leider nicht alle auf einmal rausziehen. Wir übernehmen keine Haftung für das Abschleppen von Fahrzeugen. Der Abschleppvorgang erfolgt auf eigene Verantwortung und Gefahr des Besuchers.\n\nWichtiger Hinweis:\nUmso weniger Autos – desto besser. Neben dem Appell Fahrgemeinschaften zu bilden noch folgende Information: Aufgrund des kurzfristigen Locationwechsels haben wir keinen befestigten Parkplatz. Allerdings steht uns ein Feld zur Verfügung, welches wir als Parkplatz nutzen dürfen. Je nach Wetter kann es hier also schnell schlammig werden und man muss mit Schwierigkeiten bei der An- und Abreise mit dem Auto rechnen. Lasst Euch also im besten Fall zum Festival fahren oder nutzt die öffentlichen Verkehrsmittel - genauer gesagt den Bus.", softWrap: true, maxLines: 5, overflow: TextOverflow.ellipsis),
                    expanded: Text("Sollte der Parkplatz bei An- oder Abreise durch anhaltenden Regen sehr nass geworden sein, bitten wir Euch, so vorsichtig wie es geht über diese Flächen zu fahren. Bitte befolgt immer die Anweisungen unserer Einweiser und habt Geduld, sollte es wider Erwarten zu Verzögerungen bei der An- oder Abreise kommen.Wetterbedingt kann es passieren, dass sich Autos festgefahren haben. In diesem Fall tun wir unser Möglichstes, um alle Betroffenen mit einem Traktor abzuschleppen. Präpariert Euren Wagen mit dem Abschlepphaken, schaltet die Warnblinkanlage an und habt etwas Geduld, denn: wenn es wirklich nass ist, muss bei jedem Abschleppen behutsam vorgegangen werden. Wir können leider nicht alle auf einmal rausziehen. Wir übernehmen keine Haftung für das Abschleppen von Fahrzeugen. Der Abschleppvorgang erfolgt auf eigene Verantwortung und Gefahr des Besuchers.\n\nWichtiger Hinweis:\nUmso weniger Autos – desto besser. Neben dem Appell Fahrgemeinschaften zu bilden noch folgende Information: Aufgrund des kurzfristigen Locationwechsels haben wir keinen befestigten Parkplatz. Allerdings steht uns ein Feld zur Verfügung, welches wir als Parkplatz nutzen dürfen. Je nach Wetter kann es hier also schnell schlammig werden und man muss mit Schwierigkeiten bei der An- und Abreise mit dem Auto rechnen. Lasst Euch also im besten Fall zum Festival fahren oder nutzt die öffentlichen Verkehrsmittel - genauer gesagt den Bus.", softWrap: true,),
                  ),
                  Text("\n\n"),
                  ExpandablePanel(
                    header: Text("MIT BUS UND BAHN\n", textAlign: TextAlign.center, textScaleFactor: 1.5),
                    collapsed: Text("Das Kartell freut sich sehr über jede Anreise, die mit öffentlichen Verkehrsmitteln erfolgt. Die nächsten Bahnhof-Stationen sind Überlingen und Sigmaringen. Von dort aus gelangt ihr einfach und direkt mit dem Bus nach Herdwangen.\n\nAn der Haltestelle Herdwangen Bodenseestraße halten die folgenden Buslinien:\n❥ Bus 500 (naldo)\nSigmaringen - Pfullendorf - Überlingen\n\n❥ Bus 7378 (bodo)\nÜberlingen - Owingen - Herdwangen - Pfullendorf\n\n❥ Bus 7389 (bodo)\nÜberlingen - Sipplingen - Ludwigshafen - Stockach\n\nVon der Haltestelle ist man in ca. 10-15 Minuten Fußweg beim Festivalgelände. Der Fußweg ist ausgeschildert.", softWrap: true, maxLines: 5, overflow: TextOverflow.ellipsis,),
                    expanded: Text("Das Kartell freut sich sehr über jede Anreise, die mit öffentlichen Verkehrsmitteln erfolgt. Die nächsten Bahnhof-Stationen sind Überlingen und Sigmaringen. Von dort aus gelangt ihr einfach und direkt mit dem Bus nach Herdwangen.\n\nAn der Haltestelle Herdwangen Bodenseestraße halten die folgenden Buslinien:\n❥ Bus 500 (naldo)\nSigmaringen - Pfullendorf - Überlingen\n\n❥ Bus 7378 (bodo)\nÜberlingen - Owingen - Herdwangen - Pfullendorf\n\n❥ Bus 7389 (bodo)\nÜberlingen - Sipplingen - Ludwigshafen - Stockach\n\nVon der Haltestelle ist man in ca. 10-15 Minuten Fußweg beim Festivalgelände. Der Fußweg ist ausgeschildert.", softWrap: true)
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: ListView(
                children: [
                  Text("CAMPING-Regeln\n", textAlign: TextAlign.center, textScaleFactor: 2, ),
                  Text("Jedes Ticket berechtigt zum Zelt-Camping während des Festivals. Eine Anreise vor dem offiziellen Festivalbeginn ist unter keinen Umständen möglich. Das Gelände ist bereits frühzeitig umzäunt und wir lassen uns hier auf keine Diskussionen ein, da wir Euch schlicht und ergreifend von den Behörden aus nicht auf das Gelände lassen dürfen. So sorry – bitte habt Verständnis dafür.\n\n❥ Man beachte die Nachtruhe von 02.00 – 08.00 Uhr.\n\n❥ Bei der Bändelausgabe sind 5€ Müllpfand gegen eine Pfandmarke zu zahlen. Bei Rückgabe eines vollen Müllsacks mit Pfandmarke gibt es am Abreisetag ab 9.00 Uhr das Müllpfand zurück.\n\n❥ Für mitgebrachte Sofas sind 25€ Sofapfand gegen eine Pfandmarke zu zahlen. Bei Abreise mit dem mitgebrachten Sofa gibt es am Abreisetag, ab 9.00 Uhr das Sofapfand zurück.\n\n❥ Die Zufahrt zur Caravan-Camping Area (\"CARAVANA\") ist nur mit gültigem CARAVAN-PASS möglich. Gestattet sind nur Wohnmobile, Wohnwägen und Fahrzeuge mit vom Hersteller serienmäßig verbauter Schlafzelle, keine LKW, keine Rennwägen, keine Fertighäuser – bitte, danke!\n\n❥ Kleine Notstrom-Aggregate sind auf dem Campinggelände erlaubt, einzige Bedingung: Ihr müsste diese ganz normal durch eine Einlasskontrolle tragen.\n\n❥Auf dem Gesamten Camping-Gelände gilt:\n\n• Keine Drogen\n• Keine Waffen\n• Keine offenen Feuer\n• Keine Glasflaschen\n• Keine Tiere\n\n❥ Für das gesamte Veranstaltungsgelände inkl. Park- und Campingplatz gilt: Betreten auf eigene Gefahr.\n\nBei Verstoß gegen diese Regeln oder anderen kriminellen Handlungen behält sich das Kartell der Liebe vor, Hausverbot zu erteilen und Anzeige wegen Hausfriedensbruch zu erstatten.")
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: ListView(
                children: [
                  Text("Unter 18\n", textAlign: TextAlign.center, textScaleFactor: 2),
                  Text("Informationen für Besucher*innen unter 18 Jahren\n", textAlign: TextAlign.center, textScaleFactor: 1.5),
                  Text("❥ Der Einlass zur Veranstaltung erfolgt bei EINE LIEBE ab 16 Jahren.\n\n❥ Festival-Besucherinnen und Besucher unter 18 Jahren benötigen einen PARTYPASS oder die PARTYPASS-APP und erhalten nach der Personalausweiskontrolle und Vorlage des PARTYPASSES oder der PARTYPASS-APP an der Bändelausgabe einen U18-Bändel.\n❥ Das Veranstaltungsgelände ist aufgeteilt in Campinggelände und Festivalgelände. Beim Betreten des Festivalgeländes geben unter 18 jährige Besucherinnen und Besucher ihren PARTYPASS beim Sicherheitsdienst ab oder checken mit der PARTYPASS-APP ein und holen ihren Ausweis beim Verlassen des Festival-Geländes wieder an gleicher Stelle ab oder checken mit der PARTYPASS-APP aus.\n❥ Festival-Besucherinnen und Besucher unter 18 Jahren müssen das Festivalgelände um 24 Uhr verlassen, dürfen jedoch auf dem Campingplatz ganz normal übernachten.\n❥ Wird ein PARTYPASS nicht abgeholt oder nicht rechtzeitig via PARTYPASS-APP ausgecheckt, wird diese Information zum örtlichen Bürgermeisteramt/Rathaus gebracht und die Eltern werden kontaktiert. Hierbei können Gebühren entstehen – das und den damit verbundenen Ärger solltet ihr um unser und euer aller Willen vermeiden.\n❥ Eine Aufsichtsvollmacht (“MUTTIZETTEL”) wird innerhalb des Festivalgeländes leider nicht akzeptiert. Nach langen Beratungen und unter Abwägung aller Optionen, zusammen mit den zuständigen Behörden, haben wir uns dazu entschlossen, diese Regelungen so einzuführen.\n❥ Bei Vorlage ungültiger/gefälschter Dokumenten wird kein Eintritt zum Festival gewährt und die Polizei informiert.\n❥ Für das gesamte Veranstaltungsgelände inkl. Park- und Campingplatz gilt das Jugendschutzgesetz (JuSchG).")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}