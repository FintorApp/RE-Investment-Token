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

    log("Deploying DVDTransferManager waiting for confirmations...")
    const DVD = await deploy("DVDTransferManager", {
        from: deployer,
        owner: deployer,
        args: [],
        log: true,
        waitConfirmations: waitBlockConfirmations,
    })

    // log(`DVDTransferManager deployed at ${MCProxy.address}`)
    log("\n")


}

module.exports.tags = ["all", "DVD", "Factory"]
