import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import '../components/player.dart';

class BKFFGame extends FlameGame with KeyboardEvents {
  late Player player;

  @override
  Future<void> onLoad() async {
    // Mid-century office colors
    camera.viewfinder.anchor = Anchor.topLeft;
    
    // Add the floor
    add(RectangleComponent(
      position: Vector2(0, size.y - 50),
      size: Vector2(size.x, 50),
      paint: Paint()..color = const Color(0xFF8B7355), // Wood paneling
    ));

    // Add the player (dude who can walk)
    player = Player(
      position: Vector2(100, size.y - 100),
    );
    add(player);

    return super.onLoad();
  }

  @override
  KeyEventResult onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    player.handleInput(keysPressed);
    return KeyEventResult.handled;
  }
}
