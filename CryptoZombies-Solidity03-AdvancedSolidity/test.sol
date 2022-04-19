// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

// To test if block.timestamp will update over time
contract TestTimestamp {
    function checkTimestamp() external view returns(uint){
        return block.timestamp;
    }
}

contract ArrayOperation {
    uint[] public numArray;

    function getArrayLength() public view returns(uint){
        return numArray.length;
    }

    function pushNum() public {
        numArray.push(1);
    }

    function deleteNum(uint _index) public {
        delete numArray[_index];
    }
}