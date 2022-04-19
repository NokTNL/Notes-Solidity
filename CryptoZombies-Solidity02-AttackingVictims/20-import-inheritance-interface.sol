// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

/* Import */
// import another solidity file; equivalent to including all contracts defined in that file here
import "./SimpleStorage.sol";

/* Interacting with another contract */
// A contract is a closed box and one contract cannot access the content of another contract, even if they are in the same file.
// Below shows how you can access one contract from another contract:

/* 1. Contract inheriatnce using "is" */
// We can inherit from a (local) contract to access the variables & methods inside.
// An inherited contract has all the state variables and methods its parent contract have
contract FancyStorage is SimpleStorage {
   // Try deploying this contract and you will have access to all the parent's variables and methods
   // !! It is NOT an INSTANCE of the parent contract.
}

/* 2. Interfaces (ABI) */
// If:
// - We only need a subset of a contract's functions
// - the contract is not defined locally, but persist somewhere on the blockchain
// Then we can use an INTERFACE, which is like a window opened for you to interact with a contract on the blockchain (think API)

// The below is the "Abstract contract" implementation of interfaces. It has function inside does not have a function body
// And you don't need to include all functions in the expected contract, just name only what you need.
// !! How you should specify an abstract contract changes A LOT between different Solidity versions. Here is for ^0.6.0:
abstract contract NumberInterface {
   // This function needs the "virtual" modifier in ^0.6.0
  function getNum(address _myAddress) public view virtual returns (uint); // no {} function body!
}
// Alternatively, use the newer "interface" keyword. "interface" is more restrictive than abstract contracts.
interface StorageInterface {
   // functions in an "interface" must have "external" visibility
  function store(uint256 _favoriteNumber) external;
  function retrieve() external view returns(uint256);
}

// To use an interface, you need to know the address of your target contract (every deployed contract has an address!
// Then, you use the interface like a FUNCTION by passing in your target address:
contract ViewStorage {
   // Deploy the SimpleStorage on-chain first so that you will get the address below:
   address storageAddress = 0xf8e81D47203A594245E36C48e151709F0C19fBe8;
   // Note that the "contract" you get back is also of the same "interface type":
   StorageInterface myStorage = StorageInterface(storageAddress);
   // What you get now is an interface that has access to functions in another smart contract on-chain. So cool!

   // You can now use the functions you specified in your interface like using that in the target contract:
   function storeThenRetrieve(uint256 _num) public returns (uint256) {
      myStorage.store(_num);
      return myStorage.retrieve();
   }
}
