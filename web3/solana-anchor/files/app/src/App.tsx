import React, { useMemo } from "react";
import {
  ConnectionProvider,
  WalletProvider,
} from "@solana/wallet-adapter-react";
import { WalletModalProvider } from "@solana/wallet-adapter-react-ui";
import { clusterApiUrl } from "@solana/web3.js";
import { CounterProgram } from "./CounterProgram";
import "@solana/wallet-adapter-react-ui/styles.css";

export default function App() {
  const endpoint = useMemo(() => "http://localhost:8899", []);

  return (
    <ConnectionProvider endpoint={endpoint}>
      <WalletProvider wallets={[]} autoConnect>
        <WalletModalProvider>
          <div style={{ maxWidth: 600, margin: "40px auto", padding: 20 }}>
            <h1>{{PROJECT_NAME}}</h1>
            <p>Solana Counter dApp</p>
            <CounterProgram />
          </div>
        </WalletModalProvider>
      </WalletProvider>
    </ConnectionProvider>
  );
}
