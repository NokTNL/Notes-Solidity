// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "./SimpleStorage.sol";

contract StorageFactory {

    SimpleStorage[] public simpleStorageArray;
    // If you call the getter function of this array to return one of its items, it returns the contract's ADDRESS

    function createContract() public {
        /* New instance of a contract */
        // Remember a contract is like a class in Solidity, so you can declare a new instance of it
        // Note that you need a TYPE for the contract and it takes the same name:
        SimpleStorage simpleStorage = new SimpleStorage();
        /****** Where is this saved? memory?****/
        simpleStorageArray.push(simpleStorage);
    }

    // Interacting with an imported contract via ABI
    // This function retrieve a contract from the array from an index, then store a number in it
    function sfStore(uint256 _index, uint256 _storageNum) public {
        // An IMPORTED CONTRACT will have an interface defined for us already!!
        // Here simpleStorageArray[_index] returns the contract's ADDRESS:
        SimpleStorage selectedStorage = SimpleStorage(simpleStorageArray[_index]);
        // Now we can use the interface to use SimpleStorage's methods:
        selectedStorage.store(_storageNum);
    }

    // Get info from a contract
    function sfGet(uint256 _index) public view returns(uint256) {
        SimpleStorage selectedStorage = SimpleStorage(simpleStorageArray[_index]);
        // !! Can't directly access "favoriteNumber" here!!!  Default visiblility for state variables is "internal"
        return selectedStorage.retrieve();
    }
}