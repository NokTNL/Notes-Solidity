// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract ExternalContract {
    error customError(string);
    function normalCall(uint _testNum) external pure returns(uint){
        return _testNum;
    }
    function revertCall() external pure returns(string memory) {
        // assert(false);
        // revert("ExternalContract.revertCall reverts");
        // revert customError("ExternalContract.revertCall throws customError");
        return "ExternalContract.revertCall successful";
    }
}

contract RevertConstructorContract {
    constructor() {
        revert("ExternalContract.constructor reverts");
    }
}