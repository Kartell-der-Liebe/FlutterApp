import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class GamesPage extends StatelessWidget {
  final String title;

  GamesPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Games"),
            bottom: const TabBar(
              tabs: [
                Tab(text: "Münzwurf"),
                Tab(text: "Würfeln")
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // Münzwurf Tab
              Center(
                child: CoinToss(),
              ),
              // Würfel Tab
              Center(
                  child: DiceRoll(),
              ),
            ],
          ),
        ));
  }
}

class CoinToss extends StatefulWidget {
  @override
  State<CoinToss> createState() => _CoinTossState();
}

class _CoinTossState extends State<CoinToss> {

  bool _coinEnabled = true;

  SMIInput<bool>? getBack;
  SMIInput<bool>? getFront;

  void _onInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
        artboard, 'Toss', onStateChange: _onStateChange);
    artboard.addController(controller!);
    getBack = controller.findInput<bool>("GetBack");
    getBack!.value = false;
    getFront = controller.findInput<bool>("GetFront");
    getFront!.value = false;
  }

  void _onStateChange(String stateMachineName, String stateName) {
    if (stateName != "Front" && stateName != "Back") {
      // Enable it after 7s (duration of the animation is max. 6 seconds)
      Timer(Duration(seconds: 7), () {
        getFront?.change(false);
        getBack?.change(false);
        setState(() => _coinEnabled = true);
      });
    }
  }

  void tossCoin() {
    setState(() => _coinEnabled = false);
    bool tossFront = Random().nextBool();
    // set the respective input to trigger correct animation
    getFront?.change(tossFront);
    getBack?.change(!tossFront);
  }


  @override
  Widget build(BuildContext context) {
    return ListView(
        children: <Widget>[
          Center(
            child: GestureDetector(
                child: SizedBox(width: 600, height: 600,
                    child: RiveAnimation.asset("assets/animations/coin.riv",
                        onInit: _onInit)
                ),
                onVerticalDragEnd : (DragEndDetails details) {
                  if (_coinEnabled) {
                    tossCoin();
                  }
                }
            ),
          ),
          Center(child: Text(_coinEnabled ? "Jetzt werfen" : "..."))
        ]);
  }
}

class DiceRoll extends StatefulWidget {
  @override
  State<DiceRoll> createState() => _DiceRollState();
}

class _DiceRollState extends State<DiceRoll> {

  bool _diceEnabled = true;

  SMIInput<double>? rollResult;
  SMITrigger? _reroll;

  void _onInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
        artboard, 'Roll', onStateChange: _onStateChange);
    artboard.addController(controller!);
    rollResult = controller.findInput<double>("Result") as SMINumber;
    rollResult!.value = 0;
    _reroll = controller.findInput<bool>("Reroll") as SMITrigger;
  }

  void _onStateChange(String stateMachineName, String stateName) {
    if (stateName != "Idle") {
      // Enable it after 4s (duration of the animation is max. 3 seconds)
      Timer(Duration(seconds: 4), () {
        setState(() => _diceEnabled = true);
      });
    }
  }

  void rollDice() {
    setState(() => _diceEnabled = false);
    int rollNumber = Random().nextInt(6) + 1;  // get random int between 0 and 5

    rollResult?.change(rollNumber.toDouble());
    _reroll?.fire();
  }


  @override
  Widget build(BuildContext context) {
    return ListView(
        children: <Widget>[
          Center(
            child: GestureDetector(
              child: SizedBox(width: 600, height: 600,
                  child: RiveAnimation.asset("assets/animations/dice.riv",
                      onInit: _onInit)
              ),
              onVerticalDragEnd : (DragEndDetails details) {
                if (_diceEnabled) {
                  rollDice();
                }
              }
            ),
          ),
          Center(child: Text(_diceEnabled ? "Jetzt würfeln" : "..."))
        ]);
  }
}
