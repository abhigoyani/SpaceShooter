import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:spaceshooter/game/game.dart';

class Enemy extends SpriteComponent with HasGameReference<SpaceShooter> {
  Enemy({Sprite? sprite, Vector2? position, Vector2? size})
      : super(sprite: sprite, position: position, size: size);

  double _speed = 250;

  @override
  void update(double dt) {
    super.update(dt);
    position += Vector2(0, 1) * _speed * dt;
    if (position.y > game.fixedResolution.y) {
      removeFromParent();
    }
  }
}
