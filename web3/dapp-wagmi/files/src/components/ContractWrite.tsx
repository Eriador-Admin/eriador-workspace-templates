import { useState } from "react";
import { useWriteContract, useWaitForTransactionReceipt } from "wagmi";
import CounterABI from "../abi/Counter.json";

const CONTRACT_ADDRESS = "0x5FbDB2315678afecb367f032d93F642f64180aa3" as const;

export default function ContractWrite() {
  const [newNumber, setNewNumber] = useState("");
  const { data: hash, writeContract, isPending, error } = useWriteContract();
  const { isLoading: isConfirming, isSuccess } = useWaitForTransactionReceipt({ hash });

  function handleIncrement() {
    writeContract({
      address: CONTRACT_ADDRESS,
      abi: CounterABI,
      functionName: "increment",
    });
  }

  function handleSetNumber() {
    if (!newNumber) return;
    writeContract({
      address: CONTRACT_ADDRESS,
      abi: CounterABI,
      functionName: "setNumber",
      args: [BigInt(newNumber)],
    });
  }

  return (
    <div>
      <h3>Write Contract</h3>

      <div style={{ marginBottom: "1rem" }}>
        <button onClick={handleIncrement} disabled={isPending}>
          {isPending ? "Confirming..." : "Increment"}
        </button>
      </div>

      <div style={{ display: "flex", gap: "0.5rem", alignItems: "center" }}>
        <input
          type="number"
          placeholder="New number"
          value={newNumber}
          onChange={(e) => setNewNumber(e.target.value)}
          style={{ padding: "0.5rem", width: 120 }}
        />
        <button onClick={handleSetNumber} disabled={isPending || !newNumber}>
          Set Number
        </button>
      </div>

      {hash && <p style={{ marginTop: "0.5rem", fontSize: "0.875rem" }}>Tx: {hash}</p>}
      {isConfirming && <p>Waiting for confirmation...</p>}
      {isSuccess && <p style={{ color: "green" }}>Transaction confirmed!</p>}
      {error && <p style={{ color: "#c00" }}>Error: {error.message}</p>}
    </div>
  );
}
