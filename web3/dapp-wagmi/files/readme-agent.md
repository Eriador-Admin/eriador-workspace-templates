# Agent Instructions — {{PROJECT_NAME}}

This is a React dApp using wagmi + viem + RainbowKit.

## Tech Stack
- **UI**: React 18 + Vite
- **Wallet**: RainbowKit (connect UI) + wagmi (React hooks) + viem (low-level)
- **Language**: TypeScript

## Key Conventions
- wagmi config in `src/wagmi.ts` — chains, transports, connectors
- RainbowKit wraps wagmi provider in `src/main.tsx`
- Contract ABIs as JSON in `src/abi/`
- Use `useReadContract` for view/pure calls
- Use `useWriteContract` + `useWaitForTransactionReceipt` for mutations
- Use `useAccount`, `useBalance`, `useEnsName` for wallet state
- Never hardcode private keys in frontend code
