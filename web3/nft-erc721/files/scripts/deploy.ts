import { network } from "hardhat";

const { ethers } = await network.create();

const baseURI = process.env.BASE_URI || "ipfs://QmPlaceholder/";
const unrevealedURI = "ipfs://QmUnrevealedPlaceholder";

const nft = await ethers.deployContract("MyNFT", [baseURI, unrevealedURI]);
await nft.waitForDeployment();

const address = await nft.getAddress();
console.log("MyNFT deployed to:", address);
console.log("Owner:", await nft.owner());
