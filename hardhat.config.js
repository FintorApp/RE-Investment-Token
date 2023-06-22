require("@nomicfoundation/hardhat-toolbox")
require("@openzeppelin/hardhat-upgrades")
require("@nomiclabs/hardhat-ethers")
// require("hardhat-contract-sizer")
require("hardhat-deploy")
require("dotenv").config()

const POLYGON_MAINNET_RPC_URL =
    process.env.POLYGON_MAINNET_RPC_URL || "https://polygon-mainnet.alchemyapi.io/v2/your-api-key"
const MUMBAI_RPC_URL =
    process.env.MUMBAI_RPC_URL || "https://polygon-mumbai.g.alchemy.com/v2/your-api-key"
const PRIVATE_KEY = process.env.PRIVATE_KEY
const MUMBAI_PRIVATE_KEY = process.env.MUMBAI_PRIVATE_KEY
const POLYGON_PRIVATE_KEY = process.env.POLYGON_PRIVATE_KEY

// Your API key for PolygonScan, obtain one at https://etherscan.io/
const POLYGONSCAN_API_KEY = process.env.POLYGONSCAN_API_KEY || "Your polygonscan API key"

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
    solidity: {
        version: "0.8.17",
        settings: {
            optimizer: {
                enabled: true,
                runs: 1,
            },
            // viaIR: true,
        },
    },
    contractSizer: {
        alphaSort: true,
        disambiguatePaths: false,
        runOnCompile: true,
        strict: true,
        only: ["Token", "TokenProxy"],
    },
    networks: {
        hardhat: {
            hardfork: "merge",
            // If you want to do some forking set `enabled` to true
            forking: {
                url: POLYGON_MAINNET_RPC_URL,
                blockNumber: 0,
                enabled: false,
            },
            chainId: 31337,
        },
        localhost: {
            chainId: 31337,
            // gas: 12000000,
            allowUnlimitedContractSize: true,
            mining: {
                auto: false,
                interval: 30000,
            },
        },
        polygon: {
            url: POLYGON_MAINNET_RPC_URL,
            accounts: POLYGON_PRIVATE_KEY !== undefined ? [POLYGON_PRIVATE_KEY] : [],
            chainId: 137,
        },
        mumbai: {
            url: MUMBAI_RPC_URL,
            accounts: MUMBAI_PRIVATE_KEY !== undefined ? [MUMBAI_PRIVATE_KEY] : [],
            chainId: 80001,
        },
    },
    defaultNetwork: "hardhat",
    etherscan: {
        // yarn hardhat verify --network <NETWORK> <CONTRACT_ADDRESS> <CONSTRUCTOR_PARAMETERS>
        apiKey: {
            // npx hardhat verify --list-networks
            polygon: POLYGONSCAN_API_KEY,
            polygonMumbai: POLYGONSCAN_API_KEY,
        },
    },
    gasReporter: {
        enabled: false,
        currency: "USD",
        outputFile: "gas-report.txt",
        noColors: true,
        // coinmarketcap: process.env.COINMARKETCAP_API_KEY,
    },
    contractSizer: {
        alphaSort: true,
        disambiguatePaths: false,
        runOnCompile: true,
        strict: true,
        only: ["Token"],
    },
    paths: {
        sources: "./contracts",
        tests: "./test",
        cache: "./build/cache",
        artifacts: "./build/artifacts",
    },
    mocha: {
        timeout: 300000, // 300 seconds max for running tests
    },
    namedAccounts: {
        deployer: {
            default: 0, // here this will by default take the first account as deployer
            1: 0, // similarly on mainnet it will take the first account as deployer. Note though that depending on how hardhat network are configured, the account 0 on one network can be different than on another
        },
        user1: {
            default: 1, // here this will by default take the first account as deployer
        },
        user2: {
            default: 2, // here this will by default take the first account as deployer
        },
    },
}
