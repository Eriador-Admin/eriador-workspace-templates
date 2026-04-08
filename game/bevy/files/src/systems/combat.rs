use bevy::prelude::*;
use crate::components::{Bullet, Enemy, Player, ScoreText, Velocity};

const BULLET_SPEED: f32 = 500.0;
const BULLET_SIZE: f32 = 6.0;
const COLLISION_DIST: f32 = 30.0;

#[derive(Resource)]
pub struct Score(pub i32);

pub fn shoot(
    mut commands: Commands,
    keyboard: Res<ButtonInput<KeyCode>>,
    query: Query<&Transform, With<Player>>,
) {
    if !keyboard.just_pressed(KeyCode::Space) {
        return;
    }

    let Ok(player_transform) = query.get_single() else {
        return;
    };

    commands.spawn((
        SpriteBundle {
            sprite: Sprite {
                color: Color::srgb(0.95, 0.9, 0.2),
                custom_size: Some(Vec2::splat(BULLET_SIZE)),
                ..default()
            },
            transform: Transform::from_translation(player_transform.translation),
            ..default()
        },
        Bullet,
        Velocity(Vec2::new(0.0, BULLET_SPEED)),
    ));
}

pub fn bullet_enemy_collision(
    mut commands: Commands,
    mut score: ResMut<Score>,
    bullets: Query<(Entity, &Transform), With<Bullet>>,
    enemies: Query<(Entity, &Transform), With<Enemy>>,
) {
    for (bullet_entity, bullet_tf) in &bullets {
        for (enemy_entity, enemy_tf) in &enemies {
            let dist = bullet_tf.translation.distance(enemy_tf.translation);
            if dist < COLLISION_DIST {
                commands.entity(bullet_entity).despawn();
                commands.entity(enemy_entity).despawn();
                score.0 += 10;
                break;
            }
        }
    }
}

pub fn player_enemy_collision(
    mut commands: Commands,
    mut score: ResMut<Score>,
    players: Query<&Transform, With<Player>>,
    enemies: Query<(Entity, &Transform), With<Enemy>>,
) {
    let Ok(player_tf) = players.get_single() else {
        return;
    };

    for (enemy_entity, enemy_tf) in &enemies {
        let dist = player_tf.translation.distance(enemy_tf.translation);
        if dist < COLLISION_DIST {
            commands.entity(enemy_entity).despawn();
            score.0 = (score.0 - 5).max(0);
        }
    }
}

pub fn update_score_display(score: Res<Score>, mut query: Query<&mut Text, With<ScoreText>>) {
    if !score.is_changed() {
        return;
    }
    for mut text in &mut query {
        text.sections[0].value = format!("Score: {}", score.0);
    }
}
