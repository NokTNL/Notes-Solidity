## Compiling contracts

Run: `npx hardhat compile`. This will compile all contracts in the `contracts` folder.

- `compile` is a _Hardhat task_. You can create more tasks in `hardhat.config.js` <!-- How? need follow up -->
- `npx hardhat compile` will also download the compiler if not already
- Once compiled, the results will be in the `artifacts` folder. Contents in this folder is needed for deployment

#### Note:

- You can specify compiler version in `hardhat.config.js`. Even multiple versions are allowed, and Hardhat will choose the highest one that is compatible for each `.sol` file.

  - More: https://hardhat.org/guides/compile-contracts.html#multiple-solidity-versions

- Unlike Remix, you need to install the npm contract libraries from Openzeppelin/Chainlink yourself.
  - Chainlink: `npm install @chainlink/contracts`
  - OpenZeppelin: `npm install @openzeppelin/contracts`

**See example of compiled contracts in the `contracts` folder**
