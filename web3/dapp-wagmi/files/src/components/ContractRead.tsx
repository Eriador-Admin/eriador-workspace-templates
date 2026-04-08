import { useReadContract } from "wagmi";
import CounterABI from "../abi/Counter.json";

// Replace with your deployed contract address
const CONTRACT_ADDRESS = "0x5FbDB2315678afecb367f032d93F642f64180aa3" as const;

export default function ContractRead() {
  const { data: number, isLoading, error } = useReadContract({
    address: CONTRACT_ADDRESS,
    abi: CounterABI,
    functionName: "number",
  });

  return (
    <div>
      <h3>Read Contract</h3>
      <p>Counter contract at <code>{CONTRACT_ADDRESS}</code></p>
      {isLoading && <p>Loading...</p>}
      {error && <p style={{ color: "#c00" }}>Error: {error.message}</p>}
      {number !== undefined && (
        <p><strong>Current number:</strong> {number.toString()}</p>
      )}
    </div>
  );
}
