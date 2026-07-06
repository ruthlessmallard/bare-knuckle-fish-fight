import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Bullet extends SpriteComponent with HasGameRef {
  static const double speed = 600;
  Vector2 direction;

  Bullet({
    required Vector2 position,
    required this.direction,
  }) : super(
          position: position,
          size: Vector2(8, 4),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('bullet.png');
    angle = direction.angleTo(Vector2(1, 0));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += direction * speed * dt;

    // Remove if off screen
    if (position.x < 0 ||
        position.x > gameRef.size.x ||
        position.y < 0 ||
        position.y > gameRef.size.y) {
      removeFromParent();
    }
  }
}
