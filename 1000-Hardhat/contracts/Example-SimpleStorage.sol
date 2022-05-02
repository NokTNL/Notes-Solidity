// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStorage {
    uint256 public number = 777;

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }
}