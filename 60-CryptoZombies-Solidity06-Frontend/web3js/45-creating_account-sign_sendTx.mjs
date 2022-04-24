/* Setting up the JS file */

// From now on, use node.js to run these as we need to load more libraries
// To use ES modules import/export (CommonJS uses "require"), all files need to have .mjs extensions
//  - https://www.geeksforgeeks.org/import-and-export-in-node-js/ , https://nodejs.org/api/esm.html

import Web3 from "web3";
// Need dotenv to deal with .env
import dotenv from "dotenv";

(async function () {
  // dotenv.config() will make using .env directly possible
  dotenv.config();

  // Does not rely on the browser provided Web3 Provider so we need to use Infura
  // Here we use Infura's Rinkeby Websocket URL:
  const infuraRinkebyWsUrl =
    "wss://rinkeby.infura.io/ws/v3/369b266e89a446aaaea18525cbc45219";

  const web3 = new Web3(infuraRinkebyWsUrl);

  // To confirm we are using the Rinkeby network:
  const chainId = await web3.eth.getChainId();
  console.log(`On ChainId: ${chainId}`);

  /************ End of setting up **************/

  /*
   * Creating Accounts
   */
  // The code below relies on the Web3 provider node to create accounts for us
  // !!! 1. (As of 1.7.3) The official doc warns you that web3.eth.accounts is not audited
  //      2. The below will let the Web3Provider to create a private key and send it back to us. May be dangerous!!!

  // const newAccount = web3.eth.accounts.create();
  // console.log(newAccount); // will show the new A/C with its PRIVATE KEYS shown, etc.

  /* Example of the returned newAccount object:
    {
      address: '0x01dCddBf49C1646832cd9a52b155F3193A25504E',
      privateKey: '0x406b5e56483958da53f112a327af71670a0946b0443344b9f49c2449a870f1e5',
      signTransaction: [Function: signTransaction],
      sign: [Function: sign],
      encrypt: [Function: encrypt]
    }
  */

  /*
   * Sending transactions
   */
  // 1. First, you need your address & private key
  // To store them safely, they are stored in an external ".env" file (don't hard code in a repo!)
  // The address used here has ETH in the Rinkeby network
  const { ADDRESS_1, PRIVATE_KEY_1 } = process.env;
  // The address for receiving ETH
  const ADDRESS_2 = "0x56aF90d175d44F4981e015D180144Fa93314DBf3";

  // 2. Then you need to build a TRANSACTION OBJECT:
  // !!! These values are only tested for signing with web3.eth.accounts.signTransaction
  const txObject = {
    // nonce: A nonce for signing the transaction.
    // - If we use "web3.eth.accounts.signTransaction" to sign, nonce defaults to "web3.eth.getTransactionCount()" so can be omitted
    nonce: await web3.eth.getTransactionCount(ADDRESS_1),
    to: ADDRESS_2,
    value: web3.utils.toHex(web3.utils.toWei("1", "gwei")),
    gasLimit: 30000,
    // (web3.js'...signTransaction) Default to "mainnet" and "berlin", otherwise need to specify both
    chain: "rinkeby",
    hardfork: "london",
    // You can also set 'maxFeePerGas' and 'maxPriorityFeePerGas' or will be set by your Web3 Provider. ...
    // More details in the next note "47-signTx-locally"
  };

  // 3. Sign a new transaction using the tx object with the Web3Provider
  // !!! Again, it uses web3.eth.accounts and will need us to send our private key. Dangerous!!!
  // - more on signing Tx locally in the next note
  const signedTx = await web3.eth.accounts.signTransaction(
    txObject,
    PRIVATE_KEY_1
  );

  // 4. Send the signed transaction! "sendSignedTransaction" will return the receipt object
  // https://web3js.readthedocs.io/en/v1.7.3/web3-eth.html#gettransactionreceipt
  console.log("Sending your transaction...");
  const receipt = await web3.eth.sendSignedTransaction(signedTx.rawTransaction);
  console.log(`Transaction sucessful, receipt object:`);
  console.log(receipt);
})();
