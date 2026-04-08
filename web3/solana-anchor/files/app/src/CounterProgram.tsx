import React, { useState, useEffect } from "react";
import { useConnection, useWallet } from "@solana/wallet-adapter-react";
import { WalletMultiButton } from "@solana/wallet-adapter-react-ui";
import { Program, AnchorProvider, BN, web3 } from "@coral-xyz/anchor";

// After building, import the IDL from target/idl/counter.json
// For now, define a minimal placeholder
const PROGRAM_ID = new web3.PublicKey(
  "11111111111111111111111111111111"
);

export function CounterProgram() {
  const { connection } = useConnection();
  const wallet = useWallet();
  const [count, setCount] = useState<number | null>(null);
  const [counterPubkey, setCounterPubkey] = useState<string>("");
  const [status, setStatus] = useState("");

  const getProvider = () => {
    if (!wallet.publicKey) return null;
    return new AnchorProvider(connection, wallet as any, {
      commitment: "confirmed",
    });
  };

  return (
    <div>
      <WalletMultiButton />

      {wallet.publicKey && (
        <div style={{ marginTop: 20 }}>
          <p>Connected: {wallet.publicKey.toBase58()}</p>

          {counterPubkey && (
            <div style={{ marginTop: 20 }}>
              <h3>
                Counter: {count !== null ? count.toString() : "loading..."}
              </h3>
              <div style={{ display: "flex", gap: 10, marginTop: 10 }}>
                <button onClick={() => setStatus("Increment via anchor test")}>
                  Increment
                </button>
                <button onClick={() => setStatus("Decrement via anchor test")}>
                  Decrement
                </button>
              </div>
            </div>
          )}

          {status && <p style={{ marginTop: 10 }}>{status}</p>}
          <p style={{ marginTop: 20, color: "#888", fontSize: 14 }}>
            Run <code>anchor build</code> first, then import the generated IDL
            to enable full program interaction.
          </p>
        </div>
      )}
    </div>
  );
}
