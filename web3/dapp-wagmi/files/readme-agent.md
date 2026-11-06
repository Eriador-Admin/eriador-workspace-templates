# Agent Instructions — {{PROJECT_NAME}}

This is a React dApp using wagmi + viem + RainbowKit.

## Tech Stack
- **UI**: React 19 + Vite 8
- **Wallet**: RainbowKit 2 (connect UI) + wagmi 2 (React hooks) + viem 2 (low-level). wagmi stays on 2.x because RainbowKit 2.2.x peers on `wagmi ^2.9`.
- **Language**: TypeScript

## Key Conventions
- wagmi config in `src/wagmi.ts` — chains, transports, connectors
- RainbowKit wraps wagmi provider in `src/main.tsx`
- Contract ABIs as JSON in `src/abi/`
- Use `useReadContract` for view/pure calls
- Use `useWriteContract` + `useWaitForTransactionReceipt` for mutations
- Use `useAccount`, `useBalance`, `useEnsName` for wallet state
- Never hardcode private keys in frontend code
