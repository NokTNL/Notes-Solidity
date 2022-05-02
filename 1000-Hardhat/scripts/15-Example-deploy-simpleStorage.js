// You need the HRE and the ethers library from it to run the scripts
const hre = require("hardhat");

async function main() {
  // 1. grab the contract NAME you want (not PATH)
  // This will create a CONTRACT FACTORY object that you can chuck out new contracts from
  // !!! Note that most of the ethers methods below returns PROMISES
  const ssFactory = await hre.ethers.getContractFactory("SimpleStorage");
  // 2. Deploy a new contract
  // - the contract factory has a `deploy` method that resolves when the deployment transaction is SENT
  // - It returns a JS CONTRACT OBJECT back that reference to the deployed contract, attached with its address, deployTransaction, etc.
  // - Pass paramters supposed to be passed into the contract's constructor in deploy()
  // !!! By default it is deployed to the Hardhat Network (a local Ethereum network for testing)
  const simpleStorage = await ssFactory.deploy();
  // Since the transaction is sent, you can access its address and transaction details, etc.
  console.log(`Deployed address: ${simpleStorage.address}`);
  console.log("Deployment Transaction:");
  console.log(simpleStorage.deployTransaction); // the deployment transaction object; ONLY AVAILABLE when deployed by a ContractFactory
  /*
   * !!! The deployment transaction is SENT does not mean the block has been MINED!!
   * Explanation: https://docs.ethers.io/v4/api-contract.html#deployment (It is ethers v4 but more thorough explanation))
   */
  console.log(simpleStorage.deployed()); // This will return a PENDING promise == block not mined yet!
  // To confirm the block has been MINED, we wait for the deployTransaction to be confirmed by the certain number of mined blocks:
  // e.g. deployTransaction.wait(1) for 1 block confirmation
  // More on transaction.wait() in bullet point 4 below
  // Note:
  // - on v5 document: https://docs.ethers.io/v5/api/contract/contract-factory/#ContractFactory-deploy
  // - In Hardhat Network, it will seem fine even without awaiting the transaction to be mined because Hardhat Network mine a block IMMEDIATELY on transaction without delay.
  await simpleStorage.deployTransaction.wait(1);
  // Alternatively, check with contract.deployed().
  // It checks deployTransaction if present (i.e. deployed by a ContractFactory), but it can check ANY contract if they are deployed on contract.address
  //  - Exaplanation of deployTransaction vs deployed: https://github.com/ethers-io/ethers.js/discussions/1577
  //  - use of deployed in v4 reference: https://docs.ethers.io/v4/api-contract.html?highlight=contract%20deployed#waiting-for-deployment
  await simpleStorage.deployed();

  // 3. Calling contract methods (read-only)
  // Your contract object has all the contract functions as stated in the Solidity contract as members
  // e.g. the getter function for the uint "number":
  let number = await simpleStorage.number();
  console.log(number); // !! This returns a BigNumber object!
  /*
   * BigNumber in ethers.js
   */
  // Because the typical size of numbers in Solidity (uint256) exceeds what can be handled by JS (64-bit), ...
  // ... ethers provide a BigNumber object wrapper for values, with value stored as a string
  // Ethers can internally convert a number denoted as STRINGS (and more value types) and manipulate them as numbers for you

  // 4. Calling contract methods (with tx)
  // - If a contract method that will trigger a transcation is called, it returns a `TransactionResponse` OBJECT once set up
  // !!! Pass numbers in as STRINGS for number safety
  const transaction = await simpleStorage.setNumber("888");
  //
  // transaction.wait(<num-of-blocks>): returns a RECEIPT Promise that resolves once the transaction has been confirmed by the number of mined blocks specified
  // - default to ONE BLOCK if no num-of-block supplied
  // - !!! By default, Hardhat Network only mines ONE block for each transaction sent, so number > 1 here won't work
  const receipt = await transaction.wait();
  // console.log("Receipt:");
  // console.log(receipt);
  /*
   * !!! You CANNOT receive values returned from a transaction call!!
   * https://docs.ethers.io/v5/api/contract/contract/#Contract--write
   * Use a Solidity event, EVM log or hardhat's console.log instead
   */
  // Alternatively, call the getter function to see if updated:
  number = await simpleStorage.number();
  console.log(number);
}

// By Hardhat: We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
