// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./ExternalContract.sol";

contract ErrorHandling {
    // Exceptions in Solidity, in general, are STATE-REVERTING.
    // That means it will undo all the changes made during that transaction till when the exception is thrown.

    /*
     * "require" and Error
     */
    // "require" is a FUNCTION that will throw exception if a condition evaluates to false. ALL UNCONSUMED GAS IS RETURNED to msg.sender
    // You can also include an optional string message when thrown.
    //  - "require" will then return an Error type error with the string type message in it.

    function sayHiToVitalik(string memory _name) public pure returns (string memory) {

        // Example: compares if _name equals "Vitalik". Throws an error and exits if not true.
        // (Side note: Solidity doesn't have native string comparison, so we
        // compare their keccak256 hashes to see if the strings are equal. see below)
        require(keccak256(abi.encodePacked(_name)) == keccak256(abi.encodePacked("Vitalik")), "Who are you talking to?");
        // If it's true, proceed with the function:
        return "Hi!";
    }

    /*
     * "revert" and custom errors
     */
    // The "revert" STATEMENT will revert the transaction and returns a custom error
    // Define a custom error like this; it can take arguments
    error notEqualToZero(string, uint256);
    function testRevert() public pure {
        uint256 testNum = 1;
        if (testNum != 0) {
            revert notEqualToZero("Caught ya!", testNum);
        }
    }
    //
    // There is also a backward-compatible revert FUNCTION:
    // - revert() --> exception with no data
    // - revert(message) --> exception with Error(string) type error
    // - `require(cond, message);` is equivalent to `if (!cond) revert(message);`
    // In general it saves more gas to revert with custom errors than using revert messages


    /*
     * "assert" and Panic
     */
    // https://ethereum.stackexchange.com/questions/15166/difference-between-require-and-assert-and-the-difference-between-revert-and-thro/24185#24185
    // According to Solidity docs:
    // "Assert should only be used to test for internal errors, and to check invariants."
    // So it should be used to check if something DISASTROUS or SHOULD NEVER HAPPEN has happened, like a number that should never change has been changed
    // 
    // "assert" test for a boolean condition. If the cond. is false, it will throw exception and CONSUMES ALL YOUR GAS (in older Solidity versions).
    //     - !!! From 0.8.0 it will no longer consume all gas. See the link below.
    // It will also generate an Panic type error with a uint256 error code.
    // More on the Panic error code: https://docs.soliditylang.org/en/v0.8.13/control-structures.html#panic-via-assert-and-error-via-require
    function testAssert() public pure {
        uint256 num1 = 0;
        uint256 num2 = num1; // A copy of num1

        // Accidentally changed num1
        num1 = 2;
        assert(num1 == num2); // This will revert the transaction
    }

    /*
     * try ... catch (Available since 0.6)
     */
    // (As of ^0.8.0) "try" in Solidity only catch exceptions ONE SINGLE EXTERNAL function call or CONTRACT CREATION call.
    // Syntax: `try externalContract.func() {...} `
    //
    // Quite different from JavaScript's try...catch:
    // - If no exceptions in the "try"-ed call, the code INSIDE THE TRY BLOCK is run (the "successful" code)
    //      - If the called function will return something, you can pass in the return value in the try block:
    //        ```
    //          uint myNum;
    //          try externalContract.func() returns (uint v){
    //              myNum = v;
    //          }
    //        ```
    //      - Then call catch blocks are skipped and will execute code after the catch blocks
    // - If exceptions are thrown in the call:
    //      - Changes made in the whole transaction till this point will be REVERTED
    //      - One of the catch blocks below will go into execution. Function call will TERMINATE after the catch block
    // - Each "catch" block catches a different type of error:
    //      - catch Error(string memory message) {}, catch Panic(uint errorcode) {}: will receive the Error meassage or Panic error code, respectively
    //      - catch (bytes memory lowLevelData) { ... } : will run if does not match the Error or Panic type error
    //      - catch { ... } : same as above but receives no error data, if you are not interested in it
    //      - There is currently no elegant way to catch data from a custom error

    function testTryCatch() public returns(string memory){
        // try testAssert() {} ...      <--- This does not work as it is an INTERNAL function
        
        // Below is an example of external function call:
        ExternalContract externalContract = new ExternalContract();
        string memory successfulReturnString;
        try externalContract.revertCall() returns(string memory receivedString){
            successfulReturnString = receivedString;
        } catch Error(string memory reason) {
            return reason;
        } catch Panic(uint errorcode) {
            if (errorcode == 1) return "externalContract.revertCall asserts";
            else return "externalContract.revertCall throws Panic for unknown reason";
        } catch {
            return "externalContract.revertCall throws unknown error type";
        }
        return successfulReturnString;
    }

    // An example of try..catch contract creation call
    function tryCatchNewContract() public returns(string memory){
        try new RevertConstructorContract() {
            return "Try new RevertConstructorContract() succesful!";
        } catch Error(string memory reason) {
            return reason;
        } catch {
            return "new RevertConstructorContract() throws unknown error type";
        }
    }

    // !!!!! Notes:
    // 1. Code INSIDE the try block is not caught and can still throw exception then revert 
    // 2. It only catches exceptions INSIDE the external call. The expression of the call, e.g. paramters passed in as a reverted call, will still be uncaught. See below for examples
    function tryCatchRevertedParam() public returns(string memory){
        ExternalContract externalContract = new ExternalContract();
        try externalContract.normalCall(throwForZero(0)) { // throwForZero will throw uncaught exception here 
            return "Try externalContract.normalCall(throwForZero(0)) succesful!";
        } catch {
            return "Catch externalContract.normalCall(throwForZero(0))!";
        }
    }
    function throwForZero(uint _testNum) public pure returns(uint){
        require(_testNum != 0, "You input zero!");
        return _testNum;
    }
}