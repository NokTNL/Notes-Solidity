// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Tutorial {
    // Ether in Solidity are all denoted in WEI (10^18 wei == 1 ether)
    // Solidity provides the aliases below and they all converts back to wei unit:
    /* 
    assert(1 wei == 1);
    assert(1 gwei == 1e9);
    assert(1 szabo == 1e12);
    assert(1 finney == 1e15);
    assert(1 ether == 1e18);
    */
    // The global "msg.value" variable shows how much ETH is sent to this contract in a tx

    /* The "payable" function modifier & the "address payable" type */
    // It makes a function capable of RECIEVING ETHER from a tx and STORING it
    function payableFunction() payable public returns(uint){
        require(msg.value >= 1 gwei);
        // ? How about if we want to WITHDRAW ETHER from this contract?

        // - Every address in Ethereum (both normal/contract addresses) has the member "balance" that ... 
        // ... shows the ether balance associated with it.
        // To view the balance of the contract:
        // return address(this).balance;
        //                ^ !!! "this" refers to the current CONTRACT INSTANCE and is explicitly convertable to address
        //                  More: https://docs.soliditylang.org/en/latest/units-and-global-variables.html#contract-related

        // - There is also an "address payable" type. It is the same as "address" except:
        //      - It can RECEIVE ether, normal addresses can't
        //      - it has the transfer() member functions ( also send(), but this is low-level)
        // To send ether from this contract back to the msg.sender, you need to explicitly convert it into a payable address:
        payable(msg.sender).transfer(address(this).balance);
    //  ^ether sink
        // !! Before 0.8.0, msg.sender used to be payable by default.
    }

    /* constructor() */
    // - constructor declaration is optional. If none specified, default to "constructor() public {}".
    // !! Prior to ^0.7.0, constrcutor needs public or internal visibility. Since 0.7.0, you SHOULD NOT add visibility to a constructor.
    // - internal constructor cannot be called externally to instantiate a new contract
    //     (e.g. you can't deploy it directly in Remix and will say it is an "abstract contract") 
}