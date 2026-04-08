use bevy::prelude::*;
use rand::Rng;
use crate::components::{Enemy, Velocity};
use crate::WINDOW_WIDTH;

const ENEMY_SIZE: f32 = 28.0;
const ENEMY_SPEED: f32 = 120.0;

#[derive(Resource)]
pub struct EnemySpawnTimer(pub Timer);

pub fn spawn_enemies(
    mut commands: Commands,
    time: Res<Time>,
    mut timer: ResMut<EnemySpawnTimer>,
) {
    timer.0.tick(time.delta());
    if !timer.0.just_finished() {
        return;
    }

    let mut rng = rand::thread_rng();
    let x = rng.gen_range((-WINDOW_WIDTH / 2.0 + ENEMY_SIZE)..(WINDOW_WIDTH / 2.0 - ENEMY_SIZE));
    let speed = ENEMY_SPEED + rng.gen_range(-20.0..40.0);

    commands.spawn((
        SpriteBundle {
            sprite: Sprite {
                color: Color::srgb(0.85, 0.2, 0.2),
                custom_size: Some(Vec2::splat(ENEMY_SIZE)),
                ..default()
            },
            transform: Transform::from_xyz(x, 320.0, 0.0),
            ..default()
        },
        Enemy,
        Velocity(Vec2::new(0.0, -speed)),
    ));
}
