import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'game/bkff_game.dart';

void main() {
  runApp(const BareKnuckleFishFightApp());
}

class BareKnuckleFishFightApp extends StatelessWidget {
  const BareKnuckleFishFightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bare Knuckle Fish Fight',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        body: GameWidget(
          game: BKFFGame(),
        ),
      ),
    );
  }
}
