# {{PROJECT_NAME}}

React dApp with [wagmi](https://wagmi.sh/), [viem](https://viem.sh/), and [RainbowKit](https://www.rainbowkit.com/) for wallet connection and smart contract interaction.

## Getting Started

```bash
bash init.sh    # install dependencies
bash run.sh     # start dev server (port 5173)
bash stop.sh    # stop dev server
```

## Features

- Wallet connection via RainbowKit (MetaMask, WalletConnect, Coinbase, etc.)
- Chain switching (Mainnet, Sepolia, Hardhat local)
- Read contract state (wagmi `useReadContract`)
- Write transactions (wagmi `useWriteContract`)
- Transaction receipts and confirmations
- ENS name resolution
- Account balance display
- TypeScript throughout

## Project Structure

```
src/
  main.tsx              # React entry + providers
  App.tsx               # Main app with wallet UI
  wagmi.ts              # wagmi config (chains, transports, connectors)
  components/
    ConnectButton.tsx    # RainbowKit connect button wrapper
    AccountInfo.tsx      # Connected account details + balance
    ContractRead.tsx     # Read from a contract
    ContractWrite.tsx    # Write to a contract
  abi/
    Counter.json         # Sample contract ABI
index.html
```

## Local Development with Hardhat

1. Start a local Hardhat node: `npx hardhat node`
2. Deploy contracts to localhost
3. Switch wallet to Hardhat network (chain ID 31337)

## Adding a New Contract

1. Add the ABI JSON to `src/abi/`
2. Import it in your component
3. Use `useReadContract` / `useWriteContract` with the ABI and address

## Requirements

- Node.js >= 18
- A browser wallet (MetaMask recommended)
