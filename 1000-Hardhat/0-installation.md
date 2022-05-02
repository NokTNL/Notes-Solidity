## Intro

- Think Hardhat like a local version of Remix - you can do compiling, deploying, calling contracts and testing of Solidity code. It has its local Ethereuem network (Hardhat Network) and ETH accounts for testing your code. And it can do much more than Remix, like running your front-end code with the contracts deployed in the local testnet, etc.

- https://hardhat.org/getting-started/

## Installation

In your folder, install hardhat: `npm install --save-dev hardhat`
Then initialise hardhat: `npx hardhat`

- As a beginner and want to see a sample project, choose `Create basic sample project` and choose the default for the remaining

- It will install `hardhat-ethers` and `hardhat-waffle` for you too. In case it doesn't: `npm install --save-dev @nomiclabs/hardhat-waffle ethereum-waffle chai @nomiclabs/hardhat-ethers ethers`

- Also useful to install the "Solidity" and "Solidity + Hardhat" VS Code extension

## Hardhat environment

- The sample project will have folders for node_modules, contracts, tests, scripts, etc.
<!-- Create new tasks? Refer to  `hardhat.config.js` -->
- **All scripts run by Hardhat will first run `hardhat.config.js`**
<!-- Need to learn more about what goes on here? -->

## Seek help

- Check all the Hardhat tasks available by running `npx hardhat` again
- For help on specific task: `npm hardhat help <task>`
