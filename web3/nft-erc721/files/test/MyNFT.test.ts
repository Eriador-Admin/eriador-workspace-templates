import { expect } from "chai";
import { network } from "hardhat";
import type { HardhatEthersSigner } from "@nomicfoundation/hardhat-ethers/types";
import type { MyNFT } from "../types/ethers-contracts/index.js";

const { ethers } = await network.create();

describe("MyNFT", function () {
  let nft: MyNFT;
  let owner: HardhatEthersSigner;
  let user1: HardhatEthersSigner;

  const BASE_URI = "ipfs://QmBaseURI/";
  const UNREVEALED_URI = "ipfs://QmUnrevealed";
  const MINT_PRICE = ethers.parseEther("0.01");

  beforeEach(async function () {
    [owner, user1] = await ethers.getSigners();
    nft = await ethers.deployContract("MyNFT", [BASE_URI, UNREVEALED_URI]);
  });

  describe("Minting", function () {
    it("should mint a single token", async function () {
      await nft.connect(user1).mint(1, { value: MINT_PRICE });
      expect(await nft.ownerOf(1)).to.equal(user1.address);
      expect(await nft.totalSupply()).to.equal(1n);
    });

    it("should mint multiple tokens", async function () {
      await nft.connect(user1).mint(3, { value: MINT_PRICE * 3n });
      expect(await nft.balanceOf(user1.address)).to.equal(3n);
    });

    it("should reject insufficient payment", async function () {
      await expect(
        nft.connect(user1).mint(1, { value: ethers.parseEther("0.005") })
      ).to.be.revertedWith("Insufficient payment");
    });

    it("should reject exceeding max per wallet", async function () {
      await nft.connect(user1).mint(5, { value: MINT_PRICE * 5n });
      await expect(
        nft.connect(user1).mint(1, { value: MINT_PRICE })
      ).to.be.revertedWith("Exceeds max per wallet");
    });
  });

  describe("Metadata", function () {
    it("should return unrevealed URI before reveal", async function () {
      await nft.connect(user1).mint(1, { value: MINT_PRICE });
      expect(await nft.tokenURI(1)).to.equal(UNREVEALED_URI);
    });

    it("should return real URI after reveal", async function () {
      await nft.connect(user1).mint(1, { value: MINT_PRICE });
      await nft.reveal(BASE_URI);
      expect(await nft.tokenURI(1)).to.equal(`${BASE_URI}1.json`);
    });
  });

  describe("Royalties", function () {
    it("should report 5% royalty", async function () {
      const [receiver, amount] = await nft.royaltyInfo(1, ethers.parseEther("1"));
      expect(receiver).to.equal(owner.address);
      expect(amount).to.equal(ethers.parseEther("0.05"));
    });
  });

  describe("Withdraw", function () {
    it("should allow owner to withdraw", async function () {
      await nft.connect(user1).mint(3, { value: MINT_PRICE * 3n });
      const balanceBefore = await ethers.provider.getBalance(owner.address);
      await nft.withdraw();
      const balanceAfter = await ethers.provider.getBalance(owner.address);
      expect(balanceAfter > balanceBefore).to.equal(true);
    });

    it("should reject non-owner withdraw", async function () {
      await expect(nft.connect(user1).withdraw()).to.revert(ethers);
    });
  });
});
