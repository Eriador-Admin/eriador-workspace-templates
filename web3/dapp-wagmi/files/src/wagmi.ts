import { getDefaultConfig } from "@rainbow-me/rainbowkit";
import { mainnet, sepolia, hardhat } from "wagmi/chains";
import { http } from "wagmi";

const projectId = import.meta.env.VITE_WALLETCONNECT_PROJECT_ID || "demo";
const alchemyKey = import.meta.env.VITE_ALCHEMY_API_KEY;

export const config = getDefaultConfig({
  appName: "{{PROJECT_NAME}}",
  projectId,
  chains: [mainnet, sepolia, hardhat],
  transports: {
    [mainnet.id]: alchemyKey
      ? http(`https://eth-mainnet.g.alchemy.com/v2/${alchemyKey}`)
      : http(),
    [sepolia.id]: alchemyKey
      ? http(`https://eth-sepolia.g.alchemy.com/v2/${alchemyKey}`)
      : http(),
    [hardhat.id]: http("http://127.0.0.1:8545"),
  },
});
