import { ethers } from "hardhat";

async function main() {
  const baseURI = process.env.BASE_URI || "ipfs://QmPlaceholder/";
  const unrevealedURI = "ipfs://QmUnrevealedPlaceholder";

  const factory = await ethers.getContractFactory("MyNFT");
  const nft = await factory.deploy(baseURI, unrevealedURI);
  await nft.waitForDeployment();

  const address = await nft.getAddress();
  console.log("MyNFT deployed to:", address);
  console.log("Owner:", await nft.owner());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
