# Agent Instructions — {{PROJECT_NAME}}

This is an ERC-721 NFT project with Hardhat + React minting frontend.

## Tech Stack
- **Smart Contract**: Solidity ^0.8.20, OpenZeppelin
- **Tooling**: Hardhat
- **Frontend**: React + Vite + ethers.js
- **Testing**: Hardhat + Chai

## Key Conventions
- Contract in `contracts/`, tests in `test/`, deploy in `scripts/`
- Frontend in `frontend/` (separate from contract code)
- Use OpenZeppelin ERC721, ERC721Enumerable, ERC2981, Ownable
- Never store images on-chain — use IPFS/Arweave for media
- Metadata JSON follows OpenSea standard
- Hardhat local network for development (chain ID 31337)
