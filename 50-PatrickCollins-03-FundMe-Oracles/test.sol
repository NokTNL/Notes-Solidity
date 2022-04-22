// SPDX-License-Identifier: MIT
pragma solidity >0.5.0 <=0.9.0;

contract Test {

    function overflow() external pure returns(uint8) {
        uint8 myNum = 255 + uint8(1); /* This will NOT give warning, but will revert when run (in ^0.8.0) */
        return myNum;
    }

    function getPrice() internal pure returns(uint) {
        return 3023512111140000000000;
    }

    function usdToWei(uint _usd) public view returns(uint) {
        // x USD = x USD / ( price (USD/10**18 ETH) * 10**(-18) (10**18 ETH/ETH) * 10**(-18) (ETH/Wei))
        //       = (x / (price * 10**(-36))) Wei = (x * 10**36 / price) Wei
        return _usd * (10**36) / getPrice();
    }
    function WeiToUsd(uint _wei) public view returns(uint) {
        // w Wei = w Wei * 10**(-18) (ETH/Wei) * 10**(-18) (10**18 ETH/ETH) * price (USD/10**18 ETH)
        //       = (w * 10**(-36) * price) USD = (w * price / 10**36) USD
        return _wei * getPrice() / (10 ** 36);
    }
}