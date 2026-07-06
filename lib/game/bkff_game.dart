import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import '../components/fighter.dart';

class BKFFGame extends FlameGame with TapCallbacks, DragCallbacks {
  late Fighter fighter;
  Vector2? activeThumbPosition;
  bool thumbDown = false;

  @override
  Future<void> onLoad() async {
    camera.viewfinder.anchor = Anchor.topLeft;
    
    // Mid-century office background
    add(RectangleComponent(
      position: Vector2.zero(),
      size: size,
      paint: Paint()..color = const Color(0xFFE8DCC8), // Beige walls
    ));
    
    // Wood paneling floor
    add(RectangleComponent(
      position: Vector2(0, size.y - 60),
      size: Vector2(size.x, 60),
      paint: Paint()..color = const Color(0xFF8B5A2B), // Wood paneling
    ));
    
    // Baseboard
    add(RectangleComponent(
      position: Vector2(0, size.y - 70),
      size: Vector2(size.x, 10),
      paint: Paint()..color = const Color(0xFF654321), // Dark wood trim
    ));

    // Add the fighter
    fighter = Fighter(
      position: Vector2(size.x / 2, size.y - 70),
    );
    add(fighter);

    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    activeThumbPosition = event.localPosition;
    thumbDown = true;
    fighter.onThumbDown(event.localPosition);
  }

  @override
  void onTapUp(TapUpEvent event) {
    if (thumbDown) {
      fighter.onThumbUp(event.localPosition);
      thumbDown = false;
    }
  }

  @override
  void onDragStart(DragStartEvent event) {
    activeThumbPosition = event.localPosition;
    thumbDown = true;
    fighter.onThumbDown(event.localPosition);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (thumbDown) {
      activeThumbPosition = event.localPosition;
      fighter.onThumbDrag(event.localPosition);
    }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    if (thumbDown && activeThumbPosition != null) {
      fighter.onThumbUp(activeThumbPosition!);
      thumbDown = false;
    }
  }

  @override
  void onDragCancel(DragCancelEvent event) {
    thumbDown = false;
  }
}
