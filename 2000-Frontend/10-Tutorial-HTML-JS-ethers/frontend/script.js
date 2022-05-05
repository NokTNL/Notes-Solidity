// Import ethers
// Just download ethers.min.js and use ES6 import here:
import { ethers } from "./ethers-5.1.esm.min.js";
// !!! (if using browserify) type this instead
// const ethers = require("ethers");

// Define abi and address; these names may need changing from time to time depending on Hardhat compiling and deployment condition
const contractAddr = "0x5fbdb2315678afecb367f032d93f642f64180aa3";
// Note that "assert" is a rather new syntax
import buildJson from "../backend/artifacts/build-info/4e21c6639abd7dfbddf2a9a4f5e000dc.json" assert { type: "json" };
// !!! (if using browserify):
// const buildJson = require("../backend/artifacts/build-info/4e21c6639abd7dfbddf2a9a4f5e000dc.json");
const abi =
  buildJson?.["output"]?.["contracts"]?.[
    "contracts/Example-SimpleStorage.sol"
  ]?.["SimpleStorage"]?.["abi"];
// To store our active account

(function dom() {
  const connectBtn = document.getElementById("connect");
  const storeBtn = document.getElementById("store");
  connectBtn.onclick = connect;
  storeBtn.onclick = store;
})();

/*
 * Conenct to wallet
 */
// By connecting it really means to let Metamask choose what account/address to connect to this website, ...
// ... thus making that address to be used in a SIGNER (see more about signer below)
async function connect() {
  // Only if Ethereum is enabled by e.g. a wallet, we try to connect
  // Note: `typeof window.ethereum !== undefined` does not work when window.ethereum is not even defined
  if (window?.ethereum) {
    // Request accounts using window.ethereum
    await ethereum.request({ method: "eth_requestAccounts" });
    console.log("Connected");
  } else alert("Ethereum is not enabled in the browser.");
}

/*
 * Calling contract methods
 */
// https://docs.ethers.io/v5/getting-started/#getting-started--glossary
async function store() {
  // !!! To do this we need to have a contract deployed to Hardhat Network first; see README.md

  // !! Note: the methods below are SYNCHRONOUS unless specified
  // PROVIDER
  // A provider is a "network provider" that allow you to access the blockchain in a read-only way
  // Metamask configures for you a provider already (e.g. Infura for Mainnet/testnet, or our local Hardhat Network), in the form `window.ethereum`.
  // To use a provider in ethers, use the ethers.providers.Web3Provider wrapper:
  const provider = new ethers.providers.Web3Provider(window.ethereum);
  // SIGNER
  // A signer is an abstraction for "address owner". It can sign transactions and has access to a private key
  // Metamask-injected provider is actually of the special class `JsonRpcProvider` so it has access to a signer (`JsonRpcSigner`) too
  const signer = provider.getSigner();
  // CONTRACT OBJECT
  // To interact with an on-chain contract, (again) you need its address and ABI, and a SIGNER (or PROVIDER)
  // These will be stored as a contract object in ethers for easy access
  // - You need to state your provider/signer because you need SOMEONE to talk to the blockchain and get the contract data!
  const contract = new ethers.Contract(contractAddr, abi, signer);
  // CALLING CONTRACT METHODS
  // !! Make sure you have connected to the wallet first! Good to have some mechanism to check if the signer has an address defined
  try {
    await signer.getAddress();
  } catch (error) {
    alert(
      "Does not seem to have an Metamask address connected this website. Try re-connect again?"
    );
    throw error;
  }
  // Now you can call your method
  let number = await contract.number();
  console.log(`Current Number: ${number.toString()}`);
  // Remember you don't get a result from a transaction call, but the transaction object
  const tx = await contract.setNumber(number.add("10"));
  await tx.wait(1);
  number = await contract.number();
  console.log(`New Number: ${number.toString()}`);
}

// !!! Below only if we use browserify AND inline script in HTML elements; need to export your functions here so that your HTML can access them
// You need to call `bundle.connect()` in HTML element if that's the case

/* module.exports = {
  connect,
  // and more functions
};
 */
