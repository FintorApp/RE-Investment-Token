const { network } = require("hardhat")
const { networkConfig, developmentChains } = require("../helper-hardhat-config")
require("dotenv").config()

const waitBlockConfirmations = developmentChains.includes(network.name)
    ? 1
    : VERIFICATION_BLOCK_CONFIRMATIONS

module.exports = async ({ getNamedAccounts, deployments }) => {
    const { deploy, log } = deployments
    const { deployer, user1 } = await getNamedAccounts()
    const deployment_args = []

    log("Deploying Trusted Issuers Registry and waiting for confirmations...")
    const tirProxy = await deploy("TrustedIssuersRegistry", {
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

    // log(`TrustedIssuersRegistryProxy deployed at ${tirProxy.address}`)
    log("\n")

    log("Deploying Identity Registry Storage and waiting for confirmations...")
    const irsProxy = await deploy("IdentityRegistryStorage", {
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

    // log(`IdentityRegistryStorageProxy deployed at ${irsProxy.address}`)
    log("\n")

    const trcProxy = await ethers.getContract("ClaimTopicsRegistry")

    log("Deploying Identity Registry and waiting for confirmations...")
    const irProxy = await deploy("IdentityRegistry", {
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
                args: [tirProxy.address, trcProxy.address, irsProxy.address],
                // args:
                // address _trustedIssuersRegistry,
                // address _claimTopicsRegistry,
                // address _identityStorage
            },
        },
    })

    // log(`IdentityRegistryStorageProxy deployed at ${irProxy.address}`)
    log("\n")
}

module.exports.tags = ["all", "IR", "Factory"]
