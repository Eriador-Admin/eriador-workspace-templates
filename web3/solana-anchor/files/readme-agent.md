# Agent Instructions — {{PROJECT_NAME}}

This is a Solana program built with the Anchor framework.

## Tech Stack
- **Program**: Rust + Anchor 1.2 (`anchor-lang` 1.2.x)
- **Tests**: TypeScript + `@anchor-lang/core` (renamed from `@coral-xyz/anchor`) + Mocha 12 via `tsx`; typed with `Program<Counter>` from `target/types/counter`
- **Frontend**: React 19 + Vite 8 + @solana/wallet-adapter (Wallet Standard); `@solana/web3.js` stays 1.x because Anchor and the wallet adapters require it
- **Network**: Solana (local validator for dev)

## Key Conventions
- Programs live in `programs/<name>/src/lib.rs`
- Instructions are `pub fn` inside `#[program]` module
- Accounts are defined with `#[derive(Accounts)]` structs
- State accounts use `#[account]` derive macro
- `anchor build` compiles and generates IDL in `target/idl/`
- `anchor test` starts local validator, deploys, and runs tests
- Program ID in `declare_id!()` must match `Anchor.toml` and deployed key
- `npm run build` = `anchor keys sync && anchor build`; keys sync writes the deploy keypair's program ID into `declare_id!()` and `Anchor.toml` (Anchor 1.x refuses to build on a mismatch)
- `npm test` = `anchor test --validator legacy` (solana-test-validator); use `.accountsPartial()` when passing accounts Anchor can resolve itself
- Use `msg!()` macro for program logging (visible in `solana logs`)
- Account space: 8 (discriminator) + serialized data size
