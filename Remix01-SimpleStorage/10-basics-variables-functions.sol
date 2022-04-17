// State your License here:
// SPDX-License-Identifier: MIT

// Define Solidity version; it has to match the compiler we are using in Solidity
// pragma solidity >=0.6.0 <0.9.0;
// ^0.6.0 means any 0.6.X, i.e. at least 0.6.0 but LOWER than 0.7.0
pragma solidity ^0.6.0;

// contract is similar to classes in an OOP language
contract SimpleStorage {
    // Variables declared here inside the contract are STATE VARIABLES
    // State variables live permanently on the blockchain

    /*  Basic data types in Solidity */
    // !! any decalred but un-initialised variables will be zero-initialised
    // !! Variables here are modifiable by default
    // ** See explanantion for the "public" modifier in the function section
    // uint === uint256, i.e. 256-bit unsigned integer
    uint256 public favUnsignedNum = 5;
    // signed integer
    int256 favSignedNum = -5; 
    bool favBool = true;
    // addresses; it is a hexadec number
    address myAddr = 0x87E7899Ce00c6316E2355BB59EaF1AD358DE95c3;

    // The below are actually special arrays; more on arrays in notes #20
    // string: Single or double quotes are both accepted for string literals
    // ** String is actually a dynamic-size byte array
    string favString = 'Hi';
    // Fixed length byte array
    // bytes1, bytes2 ... bytes32 (max.)
    // byte === byte1
    // The below will displayed as "0x436174000..." when called (afterall, all data in a computer are bytes)
    bytes32 favFixedBytes = "Cat"; 
    // Dynamic size byte array: each ASCII char requires two bytes
    bytes favDynBytes = "Dogggggg";

    /* Functions */
    // As a strong-typed language, all arguments have to have types defined in function declaration
    //
    // Visibility modifiers (e.g. "public"):
    //      - modifies the visibility of a function and state variables, e.g. "public" makes this function available to the outside world so that users can interact with
    //      - put the visibility modifier after the identifier and list of parameters
    //      - functions ALWAYS need to have visibility stated (at least for version ^0.6.0)
    //          - Even if some versions have a default visibility, it is good practice to always specifying it ...
    //          ... and set a function to private/internal if not meant to be public
    //      - By convention, private function has a leading "_"
    // ** a VARIABLE can also be declared public ("internal" by default)
    //      - visibility modifiers for variabels are BETWEEN type and indentifier
    //      - a public *getter* function will be auto-generated to access a public variable's value
    //              - the getter function is of "view" type, more on that below
    //
    // ** By convention, parameters of a function having a leading underscore "_" to differentiate from global variables
    function store(uint256 _favNum) public {
        // To change a variable in this contract based on input arguments:
        favUnsignedNum = _favNum;
    }
    // !! Whenever you deploy a contract or make any state change ...
    // (e.g. running the function above that changes your contract's variable), it will incure a transaction and gas must be spent

    // However, "view" or "pure" functions does not change any contract states and does not place a new transaction
    //      - "view" functions only read states but not changing states
    //      - "pure" functions cannot read states (e.g. pass some arguments into it and do math operations only based on what you passed in)
    // In Remix, view/pure functions has a blue button in the contract
    // "returns" limits what data type is to be returned
    function retrieve() public view returns(uint256) {
        return favUnsignedNum;
    }

    function addNum(uint256 a, uint256 b) public pure returns(uint256) {
        return a + b;
    }

    // !!!! A contract is similar to a class. Therefore, if can only contain FIELDS and METHODS declarations
    // Operations like assignment is not allowed:
    // uint test;
    // test = 5; --> throws error saying "Expected identifier"
}

