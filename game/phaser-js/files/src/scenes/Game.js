import Phaser from "phaser";

export class Game extends Phaser.Scene {
  constructor() {
    super("Game");
    this.player = null;
    this.cursors = null;
  }

  create() {
    // Create a simple player rectangle
    this.player = this.add.rectangle(400, 300, 40, 40, 0x6666ff);
    this.physics.add.existing(this.player);
    this.player.body.setCollideWorldBounds(true);

    // Keyboard input
    this.cursors = this.input.keyboard.createCursorKeys();

    // Instructions
    this.add
      .text(400, 50, "{{PROJECT_NAME}}", { fontSize: "32px", color: "#fff" })
      .setOrigin(0.5);
    this.add
      .text(400, 90, "Use arrow keys to move", {
        fontSize: "16px",
        color: "#aaa",
      })
      .setOrigin(0.5);
  }

  update() {
    const speed = 200;
    this.player.body.setVelocity(0);

    if (this.cursors.left.isDown) {
      this.player.body.setVelocityX(-speed);
    } else if (this.cursors.right.isDown) {
      this.player.body.setVelocityX(speed);
    }

    if (this.cursors.up.isDown) {
      this.player.body.setVelocityY(-speed);
    } else if (this.cursors.down.isDown) {
      this.player.body.setVelocityY(speed);
    }
  }
}
