# {{PROJECT_NAME}}

ERC-721 NFT collection with Solidity smart contract, Hardhat tooling, and a React minting page.

## Getting Started

```bash
bash init.sh    # install deps, compile, deploy to local node
bash run.sh     # start local Hardhat node + minting frontend
bash stop.sh    # stop everything
```

## Features

- ERC-721 with OpenZeppelin (battle-tested)
- Configurable max supply, mint price, and max per wallet
- Owner-only reveal/withdraw functions
- EIP-2981 royalties (on-chain)
- Metadata: base URI + per-token URI
- React minting page with wallet connect
- Hardhat tests with full coverage

## Project Structure

```
contracts/
  MyNFT.sol              # ERC-721 contract
test/
  MyNFT.test.ts          # Contract tests
scripts/
  deploy.ts              # Deployment script
frontend/
  index.html             # Minting page entry
  src/
    main.tsx             # React entry
    App.tsx              # Minting UI
    abi.ts               # Contract ABI export
metadata/
  sample/
    1.json               # Sample token metadata
hardhat.config.ts
```

## Contract Details

| Property | Value |
|----------|-------|
| Standard | ERC-721 + ERC-2981 |
| Max Supply | 1000 |
| Mint Price | 0.01 ETH |
| Max Per Wallet | 5 |
| Royalty | 5% (owner) |

## Metadata

Token metadata follows the OpenSea standard:
```json
{
  "name": "Token #1",
  "description": "...",
  "image": "ipfs://...",
  "attributes": [...]
}
```

## Requirements

- Node.js >= 18
- Browser wallet (MetaMask)
