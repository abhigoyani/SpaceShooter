import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:spaceshooter/game/bullet.dart';
import 'package:spaceshooter/game/game.dart';

class Enemy extends SpriteComponent
    with HasGameReference<SpaceShooter>, CollisionCallbacks {
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

  @override
  void onMount() {
    // TODO: implement onMount
    super.onMount();
    final shape = CircleHitbox.relative(
      0.8,
      parentSize: size,
      position: size / 2,
      anchor: Anchor.center,
    )..renderShape = true;
    add(shape);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollision
    super.onCollision(intersectionPoints, other);
    if (other is Bullet) {
      removeFromParent();
    }
  }
}
