// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract SimpleStorage {
    /* Structs: creates a new COMPOSITE data type */
    // It is functionally very *similar* to classes
    // !!! each sub-data type definition ends with SEMI-COLON, not COMMA !!
    // ** Convention: use UpperCamelCase for structs
    struct Person {
        uint256 favNum;
        string name;
    }
    // children in a struct will be assigned indexes, e.g. 0: favNum, 1: string
    // This can be seen if you try to call the variable, e.g. if you call the Person's below

    // To declare a new variable of struct type, you declare the struct type on the left, and its "constructor" on the right:
    Person newPerson = Person(172, "Satoshi");
    // Alternatively, you pass something looks like a JS object into the "constructor":
    Person newPerson2 = Person({favNum: 172, name: "Satoshi"});
    // Access children variables like a JS object
    string personName = newPerson.name;


    /* Arrays: strong typing so an array is defined with types */
    // FIXED array has length dixed:
    uint[5] fixedArray;
    // DYNAMIC Array can keep growing:
    uint[] dynamicArray;

    // ** You can also have an array of structs:
    Person[] public people;

    /* Array methods */
    function addPerson(uint _favNum, string memory _name) public {
        people.push(Person(_favNum, _name));
    }
    /* Reference types vs Value types */
    // Arrays (incl. string and bytes), structs and mappings are REFERENCE TYPES
    //      - They are passed by reference by default (but that can be modified, see "Data location" below)
    //      - strings and bytes are special types of array in Solidity
    // The simpler types, e.g. uint, bool, are VALUE TYPES and are always passed by values

    /* Data location of different types */
    // - In a contract, state variables have *storage* location
    //      - Storage variables live forever on the blockchain
    // - In a function (contract method), incl. arguments:
    //      - VALUE-TYPE variables always have *memory* location, i.e. only live during the lifetime of that function call
    //      - REFERENCE TYPE declaration needs to have its location stated EXPLICITLY
    //          - if "storage", it will be passed by REFERENCE and any change to it will persist and affects all references to it
    //          - if "memory", it will be passed by value and only this copy will be altered if doing anything to it

    /* Mappings */
    // Functionally a lookup table and syntactically similar to JS objects
    // types of keys & values need to be specified
    mapping (string => uint256) public nameToNum;
    // Now we can look up the person's favNum from their name
    function addPersonWithMap(uint _favNum, string memory _name) public {
        // Add a mapping so that we can look up the favNum from their names
        // Add a key-value pair in a mapping like a JS object:
        nameToNum[_name] = _favNum;
        people.push(Person(_favNum, _name));
    }
    // The favNum now can be looked up if we call nameToNum[<name>], e.g. in a deployed contract

}