# {{PROJECT_NAME}}

A [Solana](https://solana.com/) program built with the [Anchor](https://www.anchor-lang.com/) framework. Includes a counter program, TypeScript integration tests, and a React frontend.

## Getting Started

```bash
bash init.sh    # install deps, build program, start local validator
bash run.sh     # run tests + start frontend
bash stop.sh    # stop validator + frontend
```

## Prerequisites

- [Rust](https://rustup.rs/) (stable)
- [Solana CLI](https://docs.solana.com/cli/install-solana-cli-tools) >= 1.18
- [Anchor CLI](https://www.anchor-lang.com/docs/installation) >= 0.30
- Node.js >= 18

## Project Structure

```
programs/
  counter/
    src/
      lib.rs              # Counter program (initialize, increment, decrement, set)
    Cargo.toml
Anchor.toml                # Anchor config (cluster, program IDs, test command)
Cargo.toml                 # Workspace Cargo config
tests/
  counter.test.ts          # TypeScript integration tests
app/
  src/
    App.tsx                # React frontend with wallet adapter
    CounterProgram.tsx     # Counter interaction component
  package.json
```

## Program

The Counter program has 4 instructions:

| Instruction | Description |
|-------------|-------------|
| `initialize` | Creates a counter account, sets authority |
| `increment`  | Adds 1 to the counter |
| `decrement`  | Subtracts 1 from the counter |
| `set`        | Sets counter to arbitrary value (authority only) |

## Useful Commands

```bash
# Build the program
anchor build

# Run tests against local validator
anchor test

# Deploy to devnet
anchor deploy --provider.cluster devnet

# Get program logs
solana logs
```

## Network Config

| Network   | Cluster URL |
|-----------|------------|
| Localhost | `http://localhost:8899` |
| Devnet    | `https://api.devnet.solana.com` |
| Mainnet   | `https://api.mainnet-beta.solana.com` |
