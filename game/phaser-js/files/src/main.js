import Phaser from "phaser";
import { Boot } from "./scenes/Boot.js";
import { Game } from "./scenes/Game.js";

const config = {
  type: Phaser.AUTO,
  width: 800,
  height: 600,
  parent: "game-container",
  backgroundColor: "#1d1d2e",
  physics: {
    default: "arcade",
    arcade: {
      gravity: { y: 300 },
      debug: false,
    },
  },
  scene: [Boot, Game],
};

new Phaser.Game(config);
