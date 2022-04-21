// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

// A bank for an address to view, deposit and withdraw fund associated to its own account only
contract SecureBank {
    // Use a mapping here for storing account asset info; even derived contract have no access to it directly
    mapping (address => uint) private _accounts;

    // Deposit fund
    function deposit(uint _amount) public {
        _accounts[msg.sender] += _amount;
    }

    // View the amount of fund
    function viewFund() public view returns(uint) {
        return _accounts[msg.sender];
    }

    // Withdraw fund
    function withdraw(uint _amount) public {
        // Can't withdraw if not having enough fund!!
        require(_accounts[msg.sender] >= _amount, "You don't have enough fund to withdraw");
        _accounts[msg.sender] -= _amount;
    }
}


