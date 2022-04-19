// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract ZombieFactory {

    // In Etheruem, an address can be owned by a user or a contract

    /* Global variable in Solidity: msg.sender */
    // "msg.sender" specifies what address called this contract ...
    // ... (otherwise this contract just sits on the blockchain doing nothing)
    // Using msg.sender is a secure way to identify a user
    // e.g. we store the favorite number of the msg.sender in a mapping:
    mapping (address => uint) public addrToNum;
    function assignNum(uint256 _favNum) public {
        addrToNum[msg.sender] = _favNum;
    }

    /* "require": function will throw and terminate execution if a condition is not met */
    // You can also leave an optional string message if the require statement throws

    function sayHiToVitalik(string memory _name) public pure returns (string memory) {

        // Example: compares if _name equals "Vitalik". Throws an error and exits if not true.
        // (Side note: Solidity doesn't have native string comparison, so we
        // compare their keccak256 hashes to see if the strings are equal. see below)
        require(keccak256(abi.encodePacked(_name)) == keccak256(abi.encodePacked("Vitalik")), "Who are you talking to?");
        // If it's true, proceed with the function:
        return "Hi!";
    }

    /* Handling multiple return values */
    // It is very much like JS's destructuring assignment for arrays
    function multipleReturns() internal pure returns(uint a, uint b, uint c) {
        return (1, 2, 3);
    }
    function processMultipleReturns() external pure returns(uint, uint){
        (,, uint c) = multipleReturns();
        // Or seperate declaration from destructuring:
        uint b;
        (,b,) = multipleReturns();
        return (b, c);
    }

    /* String comparison and if ... else */
    // There is no native string comparison in Solidity. Instead, compare their HASHES.
    // "if...else" is similar to JS but the condition statement in "if" must be of BOOLEAN type (e.g. if (1) is not valid) 
    function detectKitty(string memory _species) public pure returns(string memory){
        // Add an if statement here
        if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty"))) return "Yes! It is a kitty!";
        else return "No it is not a kitty:(...";
    }

}
