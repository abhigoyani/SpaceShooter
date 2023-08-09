import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:spaceshooter/game/game.dart';

class Bullet extends SpriteComponent {
  Bullet({Sprite? sprite, Vector2? position, Vector2? size})
      : super(
          sprite: sprite,
          position: position,
          size: size,
        );

  double _speed = 450;

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    position += Vector2(0, -1) * _speed * dt;
    if (position.y < 0) {
      removeFromParent();
    }
  }
}

class BulletShooter extends Component with HasGameReference<SpaceShooter> {
  BulletShooter({required Sprite this.bullet}) : super() {
    timer = Timer(0.3, onTick: _shootBullet, repeat: true);
  }

  Sprite bullet;
  late Timer timer;

  void _shootBullet() {
    Bullet bullet = Bullet(
        sprite: this.bullet,
        size: Vector2.all(16),
        position: game.player.position.clone() + Vector2(32, 0));
    bullet.anchor = Anchor.center;
    add(bullet);
  }

  @override
  void onMount() {
    // TODO: implement onMount
    super.onMount();
    timer.start();
  }

  @override
  void onRemove() {
    // TODO: implement onRemove
    super.onRemove();
    timer.stop();
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    timer.update(dt);
  }
}
