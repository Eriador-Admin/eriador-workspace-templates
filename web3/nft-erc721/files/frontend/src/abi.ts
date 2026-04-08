// Replace with your deployed contract address
export const CONTRACT_ADDRESS = "0x5FbDB2315678afecb367f032d93F642f64180aa3";

export const NFT_ABI = [
  "function mint(uint256 quantity) external payable",
  "function totalSupply() view returns (uint256)",
  "function balanceOf(address owner) view returns (uint256)",
  "function tokenURI(uint256 tokenId) view returns (string)",
  "function ownerOf(uint256 tokenId) view returns (address)",
  "function revealed() view returns (bool)",
  "function mintedPerWallet(address) view returns (uint256)",
  "event Minted(address indexed to, uint256 tokenId)",
];
