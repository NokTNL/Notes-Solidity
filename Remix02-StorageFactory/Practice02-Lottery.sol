// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./Practice02-SecureBank.sol";

// A Lottery that take a small amount of fund and deposit into an account randomly
// As Solidity can't generate truely random number without relying on oracles, ... 
// ... we only allow each account to place bet once (still not perfect but sufficient for now)

contract Lottery is SecureBank {
    // To store if an account has placed a bet already; this lives on the blockchain forever
    mapping (address => bool) hasAddrPlacedBet;

    function placeBet(uint _betAmount) public returns(string memory){
        // Can't place a bet if:
        // 1. not enough fund in its account, or;
        // 2. has placed a bet before
        require( viewFund() >= _betAmount && hasAddrPlacedBet[msg.sender] == false );

        // Deduct the bet amount
        withdraw(_betAmount);
        hasAddrPlacedBet[msg.sender] = true;

        // Lottery
        // !! This is still not super secure, e.g. if the player knows how the random number is generated below
        // They can try until they have got an account that always wins the bet. (Hopefully) this algorithm is not 
        // decryptable to the public!
        bytes32 rand = keccak256(abi.encodePacked(uint24(msg.sender) + 29829365847239298411));
        // Decide winning or not by simply testing odd or even:
        if (uint(rand) % 2 == 1) { 
            deposit(_betAmount * 2);
            return "Win!";
        }
        else return "Lose...";
    }
}
