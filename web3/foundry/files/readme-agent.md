# Agent Instructions — {{PROJECT_NAME}}

This is a Foundry/Solidity smart contract project.

## Tech Stack
- **Language**: Solidity ^0.8.20
- **Framework**: Foundry (Forge, Anvil, Cast)
- **Testing**: Forge Test (native Solidity tests)

## Key Conventions
- Contracts in `src/`, tests in `test/`, deploy scripts in `script/`
- Test files end with `.t.sol`, scripts with `.s.sol`
- Use `forge-std` for console.log and test utilities
- Tests inherit from `forge-std/Test.sol`
- Scripts inherit from `forge-std/Script.sol`
- Use `vm.prank()`, `vm.expectRevert()`, `vm.deal()` cheatcodes
