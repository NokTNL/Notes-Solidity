## Setting up the environment

### 1. Installation

**In the backend folder**

- `npm install --save-dev hardhat`
- Then `npx hardhat` and choose "Create a basic sample project" to initiate

**In the frontend folder**

- `npm install --save ethers`

- Browser only allows ES6 modules syntax
- To use node.js syntax (e.g. `const XXX = require(YYY)`) inside a browser, you need to browserify your scripts
- `npm install browserify`

### 2. Setting up Hardhat Network & configuring Metamask

**In the backend folder**

- I copied sample contract and deployment script from `1000-Hardhat`
- The run `npx hardhat node` in one terminal
- And then `npx hardhat run scripts/15-Example-deploy-simpleStorage.js --network localhost` in another
- now we have our RPC URL to interact with: http://127.0.0.1:8545/
- Add this network to Metamask in the browser
- Import your account using the private keys provided by Hardhat Network
- Now you will see you have 10000 GO tokens!

## Go!

- `frontend/`
- Every time you try to update the browserify bundle: `npx browserify script.js --standalone bundle -o ./dist/bundle.js`
