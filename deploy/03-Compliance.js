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

    log("Deploying MCProxy waiting for confirmations...")
    const MCProxy = await deploy("ModularCompliance", {
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
                args: [],
            },
        },
    })

    // log(`ModularCompliance deployed at ${MCProxy.address}`)
    log("\n")


}

module.exports.tags = ["all", "MC", "Factory"]
