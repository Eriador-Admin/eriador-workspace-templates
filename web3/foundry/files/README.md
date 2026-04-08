# {{PROJECT_NAME}}

[Foundry](https://book.getfoundry.sh/) project for Solidity smart contract development.

## Getting Started

```bash
bash init.sh    # install Foundry + compile contracts
bash run.sh     # run tests + start local Anvil node
bash stop.sh    # stop Anvil
```

## Project Structure

```
src/
  Counter.sol          # Sample counter contract
  SimpleToken.sol      # ERC20-like token contract
test/
  Counter.t.sol        # Counter tests
  SimpleToken.t.sol    # Token tests
script/
  Deploy.s.sol         # Deployment script
foundry.toml           # Foundry configuration
```

## Commands

```bash
# Build
forge build

# Test
forge test -vvv

# Gas report
forge test --gas-report

# Deploy to local Anvil
anvil &
forge script script/Deploy.s.sol --rpc-url http://localhost:8545 --broadcast

# Format
forge fmt
```

## Contracts

### Counter
Simple counter with `increment()`, `decrement()`, and `setNumber(uint256)`.

### SimpleToken
Minimal ERC20-like token with `transfer()`, `approve()`, `transferFrom()`, and initial supply minted to deployer.

## Requirements

- Foundry (`curl -L https://foundry.paradigm.xyz | bash && foundryup`)
