import { useAccount } from "wagmi";
import ConnectButton from "./components/ConnectButton";
import AccountInfo from "./components/AccountInfo";
import ContractRead from "./components/ContractRead";
import ContractWrite from "./components/ContractWrite";

export default function App() {
  const { isConnected } = useAccount();

  return (
    <div style={{ maxWidth: 720, margin: "0 auto", padding: "2rem 1rem", fontFamily: "system-ui, sans-serif" }}>
      <h1>{{PROJECT_NAME}}</h1>
      <ConnectButton />

      {isConnected && (
        <>
          <AccountInfo />
          <hr style={{ margin: "2rem 0" }} />
          <ContractRead />
          <hr style={{ margin: "2rem 0" }} />
          <ContractWrite />
        </>
      )}

      {!isConnected && (
        <p style={{ marginTop: "2rem", color: "#666" }}>
          Connect your wallet to interact with smart contracts.
        </p>
      )}
    </div>
  );
}
