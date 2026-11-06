# {{PROJECT_NAME}}

A [Solana](https://solana.com/) program built with the [Anchor](https://www.anchor-lang.com/) framework. Includes a counter program, TypeScript integration tests, and a React frontend.

## Getting Started

```bash
bash init.sh    # install deps, build program, start local validator
bash run.sh     # run tests + start frontend
bash stop.sh    # stop validator + frontend
```

## Prerequisites

- [Rust](https://rustup.rs/) via rustup, 1.89+ (`cargo build-sbf` registers its toolchain through rustup)
- [Solana CLI (Agave)](https://docs.anza.xyz/cli/install) 4.x — provides `cargo build-sbf` and `solana-test-validator`
- [Anchor CLI](https://www.anchor-lang.com/docs/installation) 1.2.x (`avm install 1.2.2`)
- Node.js 20.19+ or 22.12+

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

`npm run build` runs `anchor keys sync` first: Anchor 1.x refuses to build while `declare_id!()` differs from `target/deploy/counter-keypair.json`. `npm test` uses `anchor test --validator legacy` (`solana-test-validator` from the Solana CLI); drop the flag to use Anchor's default Surfpool validator if you have it installed.

The frontend registers wallets through the Wallet Standard (`wallets={[]}`), which Phantom, Solflare, Backpack and other current wallets support. To add a wallet that only ships a legacy adapter, install its single `@solana/wallet-adapter-<name>` package and pass it in `wallets`.

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
# Sync the program ID into declare_id!() and Anchor.toml, then build (program + IDL + TS types)
npm run build

# Run tests against a local solana-test-validator
npm test

# Type-check the tests (after a build has generated target/types)
npm run typecheck

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
