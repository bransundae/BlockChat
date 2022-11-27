import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import * as dotenv from 'dotenv';

dotenv.config()

const config: HardhatUserConfig = {
  solidity: "0.8.17",
  networks: {
    mumbai: {
      url:process.env.POLYGON_MUMBAI_HTTPS,
      accounts: [ process.env.WALLET_PRIVATE_KEY || "" ]
    }
  }
};

export default config;
