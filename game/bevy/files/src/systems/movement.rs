use bevy::prelude::*;
use crate::components::{Bullet, Enemy, Player, Velocity};
use crate::{WINDOW_HEIGHT, WINDOW_WIDTH};

const PLAYER_SPEED: f32 = 300.0;

pub fn player_movement(
    keyboard: Res<ButtonInput<KeyCode>>,
    mut query: Query<&mut Transform, With<Player>>,
    time: Res<Time>,
) {
    let Ok(mut transform) = query.get_single_mut() else {
        return;
    };

    let mut direction = Vec2::ZERO;
    if keyboard.pressed(KeyCode::KeyA) || keyboard.pressed(KeyCode::ArrowLeft) {
        direction.x -= 1.0;
    }
    if keyboard.pressed(KeyCode::KeyD) || keyboard.pressed(KeyCode::ArrowRight) {
        direction.x += 1.0;
    }
    if keyboard.pressed(KeyCode::KeyW) || keyboard.pressed(KeyCode::ArrowUp) {
        direction.y += 1.0;
    }
    if keyboard.pressed(KeyCode::KeyS) || keyboard.pressed(KeyCode::ArrowDown) {
        direction.y -= 1.0;
    }

    if direction != Vec2::ZERO {
        direction = direction.normalize();
    }

    transform.translation.x += direction.x * PLAYER_SPEED * time.delta_seconds();
    transform.translation.y += direction.y * PLAYER_SPEED * time.delta_seconds();

    // Clamp to window
    let half_w = WINDOW_WIDTH / 2.0 - 16.0;
    let half_h = WINDOW_HEIGHT / 2.0 - 16.0;
    transform.translation.x = transform.translation.x.clamp(-half_w, half_w);
    transform.translation.y = transform.translation.y.clamp(-half_h, half_h);
}

pub fn apply_velocity(
    mut query: Query<(&mut Transform, &Velocity), (Without<Player>,)>,
    time: Res<Time>,
) {
    for (mut transform, velocity) in &mut query {
        transform.translation.x += velocity.0.x * time.delta_seconds();
        transform.translation.y += velocity.0.y * time.delta_seconds();
    }
}

pub fn remove_offscreen(
    mut commands: Commands,
    query: Query<(Entity, &Transform), (Or<(With<Bullet>, With<Enemy>)>,)>,
) {
    let limit = WINDOW_HEIGHT / 2.0 + 50.0;
    for (entity, transform) in &query {
        if transform.translation.y.abs() > limit
            || transform.translation.x.abs() > WINDOW_WIDTH / 2.0 + 50.0
        {
            commands.entity(entity).despawn();
        }
    }
}
