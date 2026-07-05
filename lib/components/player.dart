import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Player extends RectangleComponent {
  static const double speed = 200;
  static const double gravity = 800;
  static const double jumpForce = 400;
  
  Vector2 velocity = Vector2.zero();
  bool onGround = false;

  Player({required Vector2 position})
      : super(
          position: position,
          size: Vector2(40, 60),
          paint: Paint()..color = const Color(0xFF4A90E2), // Blue suit
        );

  void handleInput(Set<LogicalKeyboardKey> keysPressed) {
    velocity.x = 0;
    
    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft) ||
        keysPressed.contains(LogicalKeyboardKey.keyA)) {
      velocity.x = -speed;
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowRight) ||
        keysPressed.contains(LogicalKeyboardKey.keyD)) {
      velocity.x = speed;
    }
    if ((keysPressed.contains(LogicalKeyboardKey.arrowUp) ||
         keysPressed.contains(LogicalKeyboardKey.keyW) ||
         keysPressed.contains(LogicalKeyboardKey.space)) && onGround) {
      velocity.y = -jumpForce;
      onGround = false;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    // Apply gravity
    velocity.y += gravity * dt;
    
    // Update position
    position += velocity * dt;
    
    // Floor collision
    final floorY = game.size.y - 50 - size.y;
    if (position.y >= floorY) {
      position.y = floorY;
      velocity.y = 0;
      onGround = true;
    }
    
    // Screen bounds
    if (position.x < 0) position.x = 0;
    if (position.x > game.size.x - size.x) position.x = game.size.x - size.x;
  }
}
