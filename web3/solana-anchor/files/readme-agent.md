# Agent Instructions — {{PROJECT_NAME}}

This is a Solana program built with the Anchor framework.

## Tech Stack
- **Program**: Rust + Anchor framework
- **Tests**: TypeScript + @coral-xyz/anchor + Mocha
- **Frontend**: React + @solana/wallet-adapter
- **Network**: Solana (local validator for dev)

## Key Conventions
- Programs live in `programs/<name>/src/lib.rs`
- Instructions are `pub fn` inside `#[program]` module
- Accounts are defined with `#[derive(Accounts)]` structs
- State accounts use `#[account]` derive macro
- `anchor build` compiles and generates IDL in `target/idl/`
- `anchor test` starts local validator, deploys, and runs tests
- Program ID in `declare_id!()` must match `Anchor.toml` and deployed key
- After `anchor build`, update program ID: `anchor keys list`, then update `declare_id!()` and `Anchor.toml`
- Use `msg!()` macro for program logging (visible in `solana logs`)
- Account space: 8 (discriminator) + serialized data size
