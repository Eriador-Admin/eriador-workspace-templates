mod components;
mod systems;

use bevy::prelude::*;
use systems::{combat, movement, spawner};

const WINDOW_WIDTH: f32 = 800.0;
const WINDOW_HEIGHT: f32 = 600.0;

fn main() {
    App::new()
        .add_plugins(DefaultPlugins.set(WindowPlugin {
            primary_window: Some(Window {
                title: "{{PROJECT_NAME}}".into(),
                resolution: (WINDOW_WIDTH, WINDOW_HEIGHT).into(),
                ..default()
            }),
            ..default()
        }))
        .insert_resource(spawner::EnemySpawnTimer(Timer::from_seconds(
            1.5,
            TimerMode::Repeating,
        )))
        .insert_resource(combat::Score(0))
        .add_systems(Startup, setup)
        .add_systems(
            Update,
            (
                movement::player_movement,
                movement::apply_velocity,
                movement::remove_offscreen,
                spawner::spawn_enemies,
                combat::shoot,
                combat::bullet_enemy_collision,
                combat::player_enemy_collision,
                combat::update_score_display,
                bevy::window::close_on_esc,
            ),
        )
        .run();
}

fn setup(mut commands: Commands) {
    commands.spawn(Camera2dBundle::default());

    // Player
    commands.spawn((
        SpriteBundle {
            sprite: Sprite {
                color: Color::srgb(0.2, 0.8, 0.3),
                custom_size: Some(Vec2::new(32.0, 32.0)),
                ..default()
            },
            transform: Transform::from_xyz(0.0, -200.0, 0.0),
            ..default()
        },
        components::Player,
    ));

    // Score text
    commands.spawn((
        TextBundle::from_section(
            "Score: 0",
            TextStyle {
                font_size: 30.0,
                color: Color::WHITE,
                ..default()
            },
        )
        .with_style(Style {
            position_type: PositionType::Absolute,
            top: Val::Px(10.0),
            left: Val::Px(10.0),
            ..default()
        }),
        components::ScoreText,
    ));
}
