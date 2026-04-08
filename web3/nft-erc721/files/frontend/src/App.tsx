import { useState, useEffect } from "react";
import { BrowserProvider, Contract, formatEther, parseEther } from "ethers";
import { NFT_ABI, CONTRACT_ADDRESS } from "./abi";

export default function App() {
  const [account, setAccount] = useState<string>("");
  const [totalSupply, setTotalSupply] = useState<string>("0");
  const [quantity, setQuantity] = useState(1);
  const [minting, setMinting] = useState(false);
  const [txHash, setTxHash] = useState("");

  async function connect() {
    if (!window.ethereum) return alert("Install MetaMask");
    const provider = new BrowserProvider(window.ethereum);
    const accounts = await provider.send("eth_requestAccounts", []);
    setAccount(accounts[0]);
    await fetchSupply(provider);
  }

  async function fetchSupply(provider?: BrowserProvider) {
    const p = provider || new BrowserProvider(window.ethereum);
    const contract = new Contract(CONTRACT_ADDRESS, NFT_ABI, p);
    const supply = await contract.totalSupply();
    setTotalSupply(supply.toString());
  }

  async function mint() {
    if (!window.ethereum) return;
    setMinting(true);
    try {
      const provider = new BrowserProvider(window.ethereum);
      const signer = await provider.getSigner();
      const contract = new Contract(CONTRACT_ADDRESS, NFT_ABI, signer);
      const value = parseEther("0.01") * BigInt(quantity);
      const tx = await contract.mint(quantity, { value });
      setTxHash(tx.hash);
      await tx.wait();
      await fetchSupply(provider);
    } catch (err: any) {
      alert(err.reason || err.message);
    } finally {
      setMinting(false);
    }
  }

  return (
    <div style={{ maxWidth: 480, margin: "3rem auto", fontFamily: "system-ui", textAlign: "center" }}>
      <h1>{{PROJECT_NAME}}</h1>
      <p>Minted: {totalSupply} / 1000</p>

      {!account ? (
        <button onClick={connect} style={{ padding: "0.75rem 2rem", fontSize: "1rem", cursor: "pointer" }}>
          Connect Wallet
        </button>
      ) : (
        <div>
          <p style={{ fontSize: "0.875rem", color: "#666" }}>
            Connected: {account.slice(0, 6)}...{account.slice(-4)}
          </p>
          <div style={{ margin: "1rem 0", display: "flex", justifyContent: "center", gap: "0.5rem" }}>
            <button onClick={() => setQuantity(Math.max(1, quantity - 1))}>-</button>
            <span style={{ fontSize: "1.25rem", minWidth: 30 }}>{quantity}</span>
            <button onClick={() => setQuantity(Math.min(5, quantity + 1))}>+</button>
          </div>
          <p>Price: {(0.01 * quantity).toFixed(2)} ETH</p>
          <button
            onClick={mint}
            disabled={minting}
            style={{ padding: "0.75rem 2rem", fontSize: "1rem", cursor: "pointer" }}
          >
            {minting ? "Minting..." : `Mint ${quantity}`}
          </button>
          {txHash && <p style={{ fontSize: "0.75rem", marginTop: "1rem" }}>Tx: {txHash}</p>}
        </div>
      )}
    </div>
  );
}
