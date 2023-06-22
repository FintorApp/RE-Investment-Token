const { network } = require("hardhat")
const { networkConfig, developmentChains } = require("../helper-hardhat-config")
require("dotenv").config()

const waitBlockConfirmations = developmentChains.includes(network.name)
    ? 1
    : VERIFICATION_BLOCK_CONFIRMATIONS

module.exports = async ({ getNamedAccounts, deployments }) => {
    const { deploy, log } = deployments
    const { deployer } = await getNamedAccounts()
    const deployment_args = []

    const irProxy = await ethers.getContract("IdentityRegistry")
    const MCProxy = await ethers.getContract("ModularCompliance")
    const TokenName = "FintorFundI"
    const TokenSymbol = "FUNDI"
    const address0 = "0x0000000000000000000000000000000000000000"
    const decimals = "8"



    log("Deploying Token waiting for confirmations...")
    const token = await deploy("Token", {
        from: deployer,
        owner: deployer,
        args: [],
        log: true,
        waitConfirmations: waitBlockConfirmations,
        // gasLimit: 30000000,
        proxy: {
            proxyContract: "OpenZeppelinTransparentProxy",
            viaAdminContract: {
                name: "FintorProxyAdmin",
                artifact: "FintorProxyAdmin",
            },
            execute: {
                methodName: "init",
                args: [irProxy.address, MCProxy.address, TokenName, TokenSymbol, decimals, address0],
            },
        },
    })

    // log(`MCProxy deployed at ${tirProxy.address}`)
    log("\n")

}

module.exports.tags = ["all", "Comp", "Factory"]
