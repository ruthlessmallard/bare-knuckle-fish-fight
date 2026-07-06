import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'bullet.dart';

class Fighter extends PositionComponent with HasGameRef {
  late SpriteComponent body;
  late SpriteComponent head;
  late SpriteComponent hand;
  late SpriteComponent gun;
  late SpriteComponent gunFiring;
  
  bool isFiring = false;
  double fireTimer = 0;
  static const double fireDuration = 0.1;
  
  // Aim tracking
  Vector2 aimTarget = Vector2.zero();
  bool thumbDown = false;
  Vector2 thumbStartPos = Vector2.zero();
  static const double retouchThreshold = 30; // pixels
  
  // Animation timer
  double bobTimer = 0;

  Fighter({required Vector2 position})
      : super(
          position: position,
          size: Vector2(40, 80),
          anchor: Anchor.bottomCenter,
        );

  @override
  Future<void> onLoad() async {
    // Body (torso + legs)
    body = SpriteComponent(
      sprite: await gameRef.loadSprite('body.png'),
      size: Vector2(40, 60),
      position: Vector2(0, 20),
      anchor: Anchor.topCenter,
    );
    add(body);

    // Head
    head = SpriteComponent(
      sprite: await gameRef.loadSprite('head.png'),
      size: Vector2(24, 24),
      position: Vector2(0, 10),
      anchor: Anchor.center,
    );
    add(head);

    // Hand (pivot point for gun)
    hand = SpriteComponent(
      sprite: await gameRef.loadSprite('hand.png'),
      size: Vector2(16, 16),
      position: Vector2(10, 35),
      anchor: Anchor.center,
    );
    add(hand);

    // Gun (attached to hand)
    gun = SpriteComponent(
      sprite: await gameRef.loadSprite('gun.png'),
      size: Vector2(24, 16),
      position: Vector2(8, 0),
      anchor: Anchor.centerLeft,
    );
    hand.add(gun);

    // Firing sprite (hidden by default)
    gunFiring = SpriteComponent(
      sprite: await gameRef.loadSprite('gun_firing.png'),
      size: Vector2(24, 16),
      position: Vector2(8, 0),
      anchor: Anchor.centerLeft,
      paint: Paint()..color = Colors.transparent,
    );
    hand.add(gunFiring);

    return super.onLoad();
  }

  void updateAim(Vector2 target) {
    aimTarget = target;
    
    // Calculate angle from hand to target
    final handWorldPos = hand.absolutePosition;
    final toTarget = target - handWorldPos;
    
    // Flip body based on aim direction
    if (toTarget.x < 0) {
      body.scale.x = -1;
      head.scale.x = -1;
      hand.scale.x = -1;
    } else {
      body.scale.x = 1;
      head.scale.x = 1;
      hand.scale.x = 1;
    }
    
    // Rotate gun toward target
    hand.angle = toTarget.angleTo(Vector2(1, 0));
  }

  void onThumbDown(Vector2 pos) {
    thumbDown = true;
    thumbStartPos = pos.clone();
  }

  void onThumbUp(Vector2 pos) {
    if (!thumbDown) return;
    
    thumbDown = false;
    
    // Check if retouch is in approximately same place
    final distance = pos.distanceTo(thumbStartPos);
    if (distance < retouchThreshold) {
      fire();
    }
  }

  void onThumbDrag(Vector2 pos) {
    if (thumbDown) {
      updateAim(pos);
    }
  }

  void fire() {
    isFiring = true;
    fireTimer = fireDuration;
    
    // Show firing sprite
    gun.paint.color = Colors.transparent;
    gunFiring.paint.color = Colors.white;
    
    // Spawn bullet
    final barrelOffset = Vector2(20, 0)..rotate(hand.angle);
    final bulletPos = hand.absolutePosition + barrelOffset;
    final bulletDir = Vector2(1, 0)..rotate(hand.angle);
    
    gameRef.add(Bullet(
      position: bulletPos,
      direction: bulletDir,
    ));
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    // Handle firing animation
    if (isFiring) {
      fireTimer -= dt;
      if (fireTimer <= 0) {
        isFiring = false;
        gun.paint.color = Colors.white;
        gunFiring.paint.color = Colors.transparent;
      }
    }
    
    // Subtle head bob animation
    bobTimer += dt;
    head.position.y = 10 + (bobTimer % 1.0) * 2;
  }
}
