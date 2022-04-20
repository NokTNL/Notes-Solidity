// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "./Ownable.sol";

// !!! This is updated from past lessons so that it takes real ether (instead of depositing random user-input value)
// !!! Also, someone (any addresses) need to "recharge" the pool (== address(this).balance) with ETH ...
// ... when the pool (unfortunately) runs out of ETH because someone is withdrawing their funds.

// A bank for an address to view, deposit and withdraw fund associated to its own account only
contract SecureBank is Ownable {
    /* 
     * Instantiation: require some "initial fund" from the contract owner to prevent the bank going broke easily
     */
    constructor() payable public {
        require(msg.value >= 1 gwei, "At least 1 gwei is required to initiate SecureBank!");
    }

    /* 
     * Storage variables   
     */
    // Players need to send ether into this contract to set up an "account". One's asset value is remembered in the "_accounts" mapping.
    // This is internal to ensure no external addresses can view other address's asset.
    mapping (address => uint) internal _accounts;

    /* 
     * Functions accessible to external addresses ("users")
     */

    // Deposit ETH from msg.sender
    function playerDepositFund() external payable {
        require(msg.value > 0, "Deposit at least 1 wei!");
        _accounts[msg.sender] += msg.value;
    }

    // View the amount of fund
    function playerViewFund() external view returns(uint) {
        return _accounts[msg.sender];
    }

    // Withdraw fund back to msg.sender
    function playerWithdrawFund(uint _amount) external {
        // Can't withdraw if:
        // 1. msg.sender does not having enough fund, OR
        // 2. the bank does not have enough ETH in its balance
        // 3. _amount is smaller than 1 wei
        require(_accounts[msg.sender] >= _amount, "You don't have enough fund to withdraw");
        require(address(this).balance >= _amount, "The bank is broke now. Do you want to make donations? Call 'donateToBank()' to help!");
        require(_amount > 0, "Withdraw at least 1 wei!");
        msg.sender.transfer(_amount);
        _accounts[msg.sender] -= _amount;
    }

    /* 
     * Internal functions only accessible to the bank to implement the lottery logic
     * !!! These are only meant to be called by internal lottery mechanisms to take from/reward money to an address's account
     * !!! These functions debit/credit a player's fund but does not rely on how much fund is left in the contract's pool. Use with care!
     */
    function _accountDebit(uint _amount) internal {
        _accounts[msg.sender] += _amount;
    }

    function _accountCredit(uint _amount) internal {
        // Checking if msg.sender has enough fund to credit
        require(_accounts[msg.sender] >= _amount, "msg.sender does not have enough fund to call _accountCredit.");
        _accounts[msg.sender] -= _amount;
    }


    /* 
     * For sustaining the bank's finance:
     */

    // For recharging the contract "pool" (so that people have real ETH to withdraw), in case the bank runs out of fund.
    // Anyone can call this function, so it accepts "donations" from non-contract owner as well
    // And of course, this is not "refundable" because it is not in anyone's account
    function donateToBank() external payable {}

    // For viewing the bank's pool balance. The bank does not need to be "financially transperant", so ...
    // ... only the contract only has access to this.
    function ownerViewBankPool() public onlyOwner view returns(uint){
        return address(this).balance;
    }
}


