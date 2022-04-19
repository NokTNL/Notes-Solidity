// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Tutorial {
    /* Ownable contracts */
    // It is a popular security pattern that only allow the OWNER of the contract to use the contract's methods
    // One of the way is to copy "Ownable.sol" from the OpenZeppelin library, and then inherit from it:
    // https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol


    /* Function Modifier */
    // A modifier declaration looks like a function, but it can't be called as a function
    // It must be added to a function declaration, and the code inside the modifer will be run before the main function
    // Function modifier can have ARGUMENTS too
    modifier onlyOwner2(address _addr) {
        require(_addr == msg.sender); // If this require statement fails, the main function won't run
        _; /* When a modifier hits this line, it will go back to the main function (like a successful "return" statement) */
    }
    // A function using the modifer; The modifier have access to the main function's argument!
    function someFunc(address _addr) onlyOwner2(_addr) internal {}

    /* Struct packing to save gas */
    // https://medium.com/coinmonks/gas-optimization-in-solidity-part-i-variables-9d5775e43dde
    // https://fravoll.github.io/solidity-patterns/tight_variable_packing.html
    // Solidity assigns a 256-bits slot to every variable, regardless it is a uint256 or uint8;
    // An EXCEPTION is for variables deinfed inside STRUCTS, which the EVM attempts to pack variables SEQUENTIALLY inside the same 256-bit chunk, when possible
    // That means you want to use the smallest size and an order for best packing
    struct ExpensiveStruct {
        uint128 a;
        uint256 b;
        uint128 c;  // --> 3 slots used
    }
    struct CheapStruct {
        uint128 a;
        uint128 c;
        uint256 b; // --> only 2 slots
    }


    /* Time units */
    // All time in Solidity are in SECONDS
    // Solidity provides "seconds", "minutes", "hours", "days", "weeks" units and they all convert to seconds
    // Global variable "now" is the CURRENT BLOCK TIME and does not rely on REAL-WORLD time. Alias of "block.timestamp"
    //  - reflects the block time from 1/1/1970, in uint256. Using uint32 to store it will be enough until year 2038.

}