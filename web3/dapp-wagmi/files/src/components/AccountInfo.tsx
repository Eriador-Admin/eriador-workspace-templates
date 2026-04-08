import { useAccount, useBalance, useEnsName } from "wagmi";

export default function AccountInfo() {
  const { address, chain } = useAccount();
  const { data: balance } = useBalance({ address });
  const { data: ensName } = useEnsName({ address });

  if (!address) return null;

  return (
    <div style={{ marginTop: "1.5rem", padding: "1rem", background: "#f8f9fa", borderRadius: 8 }}>
      <h3>Account</h3>
      <p><strong>Address:</strong> {ensName || address}</p>
      <p><strong>Chain:</strong> {chain?.name} (ID: {chain?.id})</p>
      {balance && (
        <p><strong>Balance:</strong> {parseFloat(balance.formatted).toFixed(4)} {balance.symbol}</p>
      )}
    </div>
  );
}
