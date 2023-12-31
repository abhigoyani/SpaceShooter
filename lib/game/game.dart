import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:spaceshooter/game/bullet.dart';
import 'package:spaceshooter/game/enemy.dart';
import 'package:spaceshooter/game/enemy_manager.dart';
import 'package:spaceshooter/game/player.dart';

class SpaceShooter extends FlameGame with PanDetector, HasCollisionDetection {
  Offset? _pointerStartPosition;
  Offset? _pointerCurrentPosition;
  final double _joysticRadius = 60;

  late Vector2 fixedResolution;
  late Player player;
  late EnemyManager _enemyManager;
  late BulletShooter _bulletShooter;

  @override
  Future<void> onLoad() async {
    fixedResolution = Vector2(size[0], size[1]);

    final spaceShipImage = await images.load('spaceShips.png');
    final spaceShip = Sprite(spaceShipImage);

    final meteor = await images.load('spaceMeteors_001.png');
    final meteorSpirit = Sprite(meteor);

    final missile = await images.load('spaceMissiles_003.png');
    final missileSpirit = Sprite(missile);

    player =
        Player(sprite: spaceShip, size: Vector2.all(64), position: size / 2);

    _enemyManager = EnemyManager(enemySprite: meteorSpirit);

    _bulletShooter = BulletShooter(bullet: missileSpirit);

    add(player);
    add(_enemyManager);
    add(_bulletShooter);

    return super.onLoad();
  }

  // @override
  // void update(double dt) {
  //   // TODO: implement update
  //   super.update(dt);
  //   final bullets = _bulletShooter.children.whereType<Bullet>();
  //   for (final enemy in _enemyManager.children.whereType<Enemy>()) {
  //     for (final bullet in bullets) {
  //       if (enemy.containsPoint(bullet.position)) {
  //         bullet.removeFromParent();
  //         enemy.removeFromParent();
  //         break;
  //       }
  //     }
  //   }
  // }

  @override
  void handlePanStart(DragStartDetails details) {
    // TODO: implement handlePanStart
    super.handlePanStart(details);
    _pointerStartPosition = details.globalPosition;
    _pointerCurrentPosition = details.globalPosition;
  }

  @override
  void render(Canvas canvas) {
    // TODO: implement render
    super.render(canvas);
    if (_pointerStartPosition != null) {
      canvas.drawCircle(_pointerStartPosition!, _joysticRadius,
          Paint()..color = Colors.grey.withAlpha(100));
    }
    if (_pointerCurrentPosition != null) {
      var delta = _pointerCurrentPosition! - _pointerStartPosition!;
      if (delta.distance > _joysticRadius) {
        delta = _pointerStartPosition! +
            (Vector2(delta.dx, delta.dy).normalized() * _joysticRadius)
                .toOffset();
      } else {
        delta = _pointerCurrentPosition!;
      }
      canvas.drawCircle(
          delta, 20, Paint()..color = Colors.white.withAlpha(100));
    }
  }

  @override
  void handlePanDown(DragDownDetails details) {
    // TODO: implement handlePanDown
    super.handlePanDown(details);
    _pointerStartPosition = null;
  }

  @override
  void handlePanUpdate(DragUpdateDetails details) {
    // TODO: implement handlePanUpdate
    super.handlePanUpdate(details);
    _pointerCurrentPosition = details.globalPosition;
    var delta = _pointerCurrentPosition! - _pointerStartPosition!;
    if (delta.distance > 10) {
      player.setMoveDirection(Vector2(delta.dx, delta.dy));
    } else {
      player.setMoveDirection(Vector2.zero());
    }
  }

  @override
  void onPanCancel() {
    // TODO: implement onPanCancel
    super.onPanCancel();
    _pointerStartPosition = null;
    _pointerCurrentPosition = null;
    player.setMoveDirection(Vector2.zero());
  }

  @override
  void handlePanEnd(DragEndDetails details) {
    // TODO: implement handlePanEnd
    super.handlePanEnd(details);
    _pointerStartPosition = null;
    _pointerCurrentPosition = null;
    player.setMoveDirection(Vector2.zero());
  }
}
