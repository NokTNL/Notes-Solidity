// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./ownable.sol";

contract Tutorial is Ownable {
    /* "view" functions for complex lookup */
    // "view" functions called INTERNALLY still costs
    // Reason:
    // - External call on "view" functions has nothing to do to validating a new block. You can view it million times, at different time points, and the blockchain state is still the same.
    // - However, a contract's function makes an internal call on a view function (e.g. checking a "price" state) often to rely on it for further operations (e.g. deduct amount from an address), and is potentially state-changing.
    // - The blockchain needs to make sure that call is done exactly the same on different nodes. Therefore, it needs to invovle transactions
    // Therefore, make computationally expensive lookup function "external view" to save gas

    /* Memory array in functions */
    // https://docs.soliditylang.org/en/v0.6.12/types.html#allocating-memory-arrays
    // To declare an array as "memory" in a function, you need to INSTANTIATE a new array (with FIXED LENGTH, as in ^0.6.0):
    function makeMemoryArray() external view {
        uint[] memory memoryArray = new uint[](5);
        //                              ^ a constructor is used here
        // !!!! this is a FIXED-SIZE ARRAY so you don't have a push() method!!
        //      In that case, you need to do array[item] assignment and a counter to keep track of how many items have been assigned.
    }

    /* for loop */
    // identical to JS
    // We can use for-loop for looking up array in an external view function to save a lot of gas
    function loopingArr() external view {
        for (uint i = 1; i <= 10; i++) { /* some code */ }
    }
}