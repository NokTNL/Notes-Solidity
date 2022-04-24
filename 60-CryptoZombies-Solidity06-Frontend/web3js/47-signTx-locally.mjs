import Web3 from "web3";
import dotenv from "dotenv";

// ** Need the ethereumjs-tx library to sign TX LOCALLY
import Tx from "@ethereumjs/tx";
const { FeeMarketEIP1559Transaction: EIP1559Tx } = Tx;
import CommonDefault, { Chain, Hardfork } from "@ethereumjs/common";
const Common = CommonDefault.default;
const common = new Common({ chain: Chain.Rinkeby, hardfork: Hardfork.London });

(async function () {
  dotenv.config();
  const infuraRinkebyWsUrl =
    "wss://rinkeby.infura.io/ws/v3/369b266e89a446aaaea18525cbc45219";
  const web3 = new Web3(infuraRinkebyWsUrl);

  // To confirm we are using the Rinkeby network:
  const chainId = await web3.eth.getChainId();
  console.log(`On ChainId: ${chainId}`);

  // Addresses and keys
  const { ADDRESS_1, PRIVATE_KEY_1 } = process.env;

  const ADDRESS_2 = "0x56aF90d175d44F4981e015D180144Fa93314DBf3";

  /*
   * Signing transaction locally using ethereumjs-tx
   */
  // If we don't want to reply on the Web3 Provider to send transactions for us
  // !!! The transaction object can be a bit different from that for web3.eth.accounts.signTransaction():
  const txObject = {
    nonce: await web3.eth.getTransactionCount(ADDRESS_1),
    to: ADDRESS_2,
    value: web3.utils.toHex(web3.utils.toWei("1", "gwei")),
    gasLimit: 30000,
    // !!! "maxPriorityFeePerGas", "maxFeePerGas" cannot be omitted or it will throw "transaction underpriced"
    // !!! These values may or may not work depending on market situation!
    maxPriorityFeePerGas: web3.utils.toHex(web3.utils.toWei("2", "gwei")),
    maxFeePerGas: web3.utils.toHex(web3.utils.toWei("2", "gwei")),
  };

  // Instantiate a new tx
  const tx = EIP1559Tx.fromTxData(txObject, { common });

  // Sign the tx
  // Note: unlike web3.eth.accounts.signTransaction, it does not handle a lot of conversion (like string to buffered hex and serialising) so you have to do it manually:
  // https://ethereum.stackexchange.com/questions/93909/expected-private-key-to-be-an-uint8array-with-length-32
  const PRIVATE_KEY_1_BUFFER = Buffer.from(PRIVATE_KEY_1, "hex");
  const signedTx = tx.sign(PRIVATE_KEY_1_BUFFER);
  const serializedTx = signedTx.serialize();
  const rawSignedTx = "0x" + serializedTx.toString("hex");

  // Then send the transaction
  // https://web3js.readthedocs.io/en/v1.7.3/web3-eth.html#gettransactionreceipt
  console.log("Sending your transaction...");
  const receipt = await web3.eth.sendSignedTransaction(rawSignedTx);
  console.log(`Transaction sucessful, receipt object:`);
  console.log(receipt);
})();
