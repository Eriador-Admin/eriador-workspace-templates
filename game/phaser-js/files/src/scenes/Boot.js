import Phaser from "phaser";

export class Boot extends Phaser.Scene {
  constructor() {
    super("Boot");
  }

  preload() {
    // Load game assets here
    // this.load.image('player', 'assets/player.png');

    // Display loading text
    const text = this.add.text(400, 300, "Loading...", {
      fontSize: "24px",
      color: "#ffffff",
    });
    text.setOrigin(0.5);
  }

  create() {
    this.scene.start("Game");
  }
}
