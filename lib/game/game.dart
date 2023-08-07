import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:spaceshooter/game/player.dart';

class SpaceShooter extends FlameGame with ScaleDetector {
  @override
  Future<void> onLoad() async {
    final spaceShipImage = await images.load('spaceShips.png');
    final spaceShip = Sprite(spaceShipImage);

    Player player =
        Player(sprite: spaceShip, size: Vector2.all(64), position: size / 2);

    add(player);
    return super.onLoad();
  }

  late double startZoom;

  @override
  void onScaleStart(_) {
    startZoom = camera.zoom;
    print('scale start');
    debugPrint('scale start');
  }

  @override
  void onScaleUpdate(ScaleUpdateInfo info) {
    final currentScale = info.scale.global;
    if (!currentScale.isIdentity()) {
      camera.zoom = startZoom * currentScale.y;
    } else {
      camera.translateBy(-info.delta.game);
      camera.snap();
    }
  }
}
