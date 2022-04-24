import Web3 from "web3";
import dotenv from "dotenv";

import { metadata } from "./TimeLimitedLottery_metadata.mjs";
const { abi: lotteryAbi } = metadata?.output;

(async function () {
  dotenv.config();
  const infuraRinkebyWsUrl =
    "wss://rinkeby.infura.io/ws/v3/369b266e89a446aaaea18525cbc45219";
  const web3 = new Web3(infuraRinkebyWsUrl);

  // To confirm we are using the Rinkeby network:
  const chainId = await web3.eth.getChainId();
  console.log(`On ChainId: ${chainId}`);

  /* Calling contract functions that involves transactions */
  // 1. You need to sign a transaction as before, but with some changes:
  const { ADDRESS_1, PRIVATE_KEY_1 } = process.env;
  // We use our TimeLimtedLottery contract address on Rinkeby:
  const CONTRACT_ADDR = "0x893E95e4A02D56Af2B7Bfa4386D9B7F583C1C4B6";

  // Have out contract object ready:
  const lotteryContract = new web3.eth.Contract(lotteryAbi, CONTRACT_ADDR);

  const txObject = {
    nonce: await web3.eth.getTransactionCount(ADDRESS_1),
    // we need to deposit some ETH into the contract so need "value" here; can be omitted otherwise
    value: web3.utils.toHex(100000),
    // The "to" address will be your contract address
    to: CONTRACT_ADDR,
    // "data" is the FUNCTION that we want to call
    // But instead using call() on the contract method, we convert it to BYTECODE
    data: lotteryContract.methods.playerDepositFund().encodeABI(),
    gasLimit: web3.utils.toHex(100000),
    chain: "rinkeby",
    hardfork: "london",
  };

  const signedTx = await web3.eth.accounts.signTransaction(
    txObject,
    PRIVATE_KEY_1
  );

  // 2. Send the signed transaction
  console.log("Sending your transaction...");
  const receipt = await web3.eth.sendSignedTransaction(signedTx.rawTransaction);
  console.log(`Transaction sucessful, receipt object:`);
  console.log(receipt);
})();
