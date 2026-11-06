# Agent Instructions — {{PROJECT_NAME}}

This is an ERC-721 NFT project with Hardhat + React minting frontend.

## Tech Stack
- **Smart Contract**: Solidity ^0.8.20, OpenZeppelin
- **Tooling**: Hardhat 3 (ESM config, `@nomicfoundation/hardhat-toolbox-mocha-ethers`), solc 0.8.34
- **Frontend**: React 19 + Vite 8 + ethers.js 6
- **Testing**: `npx hardhat test` (Mocha 12 + Chai 6 + hardhat-ethers-chai-matchers); scripts and tests get `ethers` from `await network.create()`

## Key Conventions
- Contract in `contracts/`, tests in `test/`, deploy in `scripts/`
- Frontend in `frontend/` (separate from contract code)
- Use OpenZeppelin ERC721, ERC721Enumerable, ERC2981, Ownable
- Never store images on-chain — use IPFS/Arweave for media
- Metadata JSON follows OpenSea standard
- Hardhat local network for development (chain ID 31337)
