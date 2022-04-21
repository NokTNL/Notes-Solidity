// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./SecureBank.sol";

// Modified from the lesson "CryptoZombies-Solidity02-AttackingVictims/Practice02-Lottery.sol"
// A Lottery that take a small amount of fund and deposit into an account randomly

contract Lottery is SecureBank {

    // This is intended to only allow derived Lottery's to run it
    function placeBet(uint _betAmount) internal returns(string memory){
        // Can't place a bet if not enough fund in its account
        require( viewFund() >= _betAmount, "Not enough fund in your account");

        // Deduct the bet amount from its account
        withdraw(_betAmount);

        // Lottery process
        // *Trying* to use an updated block.timestamp to ensure randomness (this is never really secure)
        bytes32 rand = keccak256(abi.encodePacked(uint24(msg.sender) + block.timestamp));
        // Decide winning or not by simply testing odd or even:
        if (uint(rand) % 2 == 1) { 
            deposit(_betAmount * 2);
            return "Win!";
        }
        else return "Lose...";
    }
}
