const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Greeter", function () {
  let greeter;

  beforeEach(async function () {
    const Greeter = await ethers.getContractFactory("Greeter");
    greeter = await Greeter.deploy("Hello, Hardhat!");
  });

  it("should return the initial greeting", async function () {
    expect(await greeter.greet()).to.equal("Hello, Hardhat!");
  });

  it("should update the greeting", async function () {
    await greeter.setGreeting("New greeting");
    expect(await greeter.greet()).to.equal("New greeting");
  });

  it("should emit GreetingChanged event", async function () {
    await expect(greeter.setGreeting("Changed"))
      .to.emit(greeter, "GreetingChanged")
      .withArgs("Changed");
  });
});
