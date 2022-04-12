// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

// A CRUD "bank" for storing ETH addresses and its related ETH asset value
contract CryptoBank {
    // Edit asset value according to name
    // Delete account 

    // An account has an ETH address and asset value
    struct Account {
        address accountAddr;
        uint256 accountWei;
    }

    // Our list of bank accounts
    Account[] accounts;
    // For retreiving an account's index inside the "accounts" array, given the account name
    mapping (string => uint256) nameToAccountIndex;

    // Public function for adding new accounts
    // Addresses are created by hashing based on the given account name
    function addAccount(string memory _name, uint256 _wei) public {
        // Create new address
        // bytes32 -> conversion not allowed, need to first converted to uint256
        // The final address will be truncated from the uint256
        address addr = address(uint256(keccak256(abi.encodePacked(_name))));
        // Push the new account to "accounts" and get the account's index in the "accounts" array
        accounts.push(Account(addr, _wei));
        // !!! Because the mapping below will return 0 for unused keys, our id == array's index + 1 to differentiate from undefined names
        uint256 id = accounts.length;
        // Add new name to the mapping
        nameToAccountIndex[_name] = id;
    }

    // For public to check account details
    // Returning structs directly is not recommended; return its simple-type children instead
    function lookupAccount(string memory _name) public view returns(address, uint256) {
        uint256 id = nameToAccountIndex[_name];
        // If id == 0 it means the account does not exist
        if (id == 0) {return (address(0), 0);}
        // id = index in "accounts" + 1
        uint256 index = id - 1;
        address addr = accounts[index].accountAddr;
        uint256 accountWei = accounts[index].accountWei;
        return (addr, accountWei);
    }

    // Changing accountWei in a certain account, given account name
    // No checking on rather the name exists in "accounts" yet
    function editAccountAsset(string memory _name, uint _newAmount) public {
        uint256 id = nameToAccountIndex[_name];
        if (id == 0) {return;}
        accounts[id - 1].accountWei = _newAmount;
    }

    // Delete an account by setting that array element back to zero (so the id's order is not disturbed)
    function deleteAccount(string memory _name) public {
        uint256 id = nameToAccountIndex[_name];
        if (id == 0) {return;}
        // Remove the account from both "accounts" and nameToAccountIndex
        accounts[id - 1] = Account(address(0), 0);
        nameToAccountIndex[_name] = 0;
    }
}