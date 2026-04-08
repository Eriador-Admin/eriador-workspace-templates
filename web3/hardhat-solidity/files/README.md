# {{PROJECT_NAME}}

Solidity smart contracts with [Hardhat](https://hardhat.org/).

## Getting Started

```bash
bash init.sh    # install dependencies
bash run.sh     # compile & run tests
bash stop.sh    # stop local node
```

## Project Structure

```
contracts/        # Solidity smart contracts
scripts/          # Deployment scripts
test/             # Contract tests
hardhat.config.js # Hardhat configuration
```

## Commands

```bash
npx hardhat compile            # Compile contracts
npx hardhat test               # Run tests
npx hardhat node               # Start local blockchain
npx hardhat run scripts/deploy.js --network localhost  # Deploy
```

## Requirements

- Node.js 18+
