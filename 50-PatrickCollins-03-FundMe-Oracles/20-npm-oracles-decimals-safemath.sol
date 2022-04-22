// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

/* !! Deploy this contract on Rinkeby to test! */

// Remix can import npm packages, or from URL (e.g. GitHub)!
// https://remix-ide.readthedocs.io/en/latest/import.html
// (A local copy of this file is availbale in this folder too)
import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";

// SafeMath
// From Chainlink:
import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";
// From OpenZeppelin: (check if the Solidity version is the same as yours!)
// import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract FundMe {
    
    mapping(address => uint256) public addressToAmountFunded;

    /* Chainlink Oracles */
    // Think Chainlink as a set of contracts that write new data on the Ethereum blockchain constantly over time
    // The data are from the real world and have mechanisms to ensure its decentral nature
    // Therefore, any Ethereum contracts can interact with Chainlink contracts to get data of a certain time point

    function getVersion() public view returns(uint256) {
        // This is ETH/USD price feed on RINKEBY testnet
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        // Note: as of 21/4/2022 this will return version "4". But v3 still seems to be the latest version of the interface
        return priceFeed.version();
    }

    /* Decimals */
    // Solidity does not handle float numbers very well and need to denote everything in integers at the moment
    
    function getPrice() public view returns(uint256){

        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        (
            /* uint80 roundId */,
            int256 answer,
            /* uint256 startedAt */,
            /* uint256 updatedAt */,
            /* uint80 answeredInRound */
        ) = priceFeed.latestRoundData();

        // !! Remember that the returned number is real data times 10^8 (or 10^18, depends on feed)!
        // The decimal place can be checked with priceFeed.decimals()
        // So for above, if answer == 245692323701, it actually means USD/ETH = 2456.92323701, ... 
        // ... or USD/(10^8 ETH) = 245692323701
        
        // For consistency we want to make the base decimal to always be 10 ** 18 ( e.g. USD/(10^18 ETH) ), so:
        return uint256(answer) * (10 ** (18 - uint256(priceFeed.decimals())));
    }

    // Convert Wei(10^-18 ETH) into 10^-18 USD
    function getConversionRate(uint256 _ethAmount) public view returns(uint256){
        // USD/(10^18 ETH) 
        uint256 ethPrice = getPrice();
        // (10^-18 ETH) * (USD/(10^18 ETH)) = 10^-36 USD
        // We need a conversion factor 1 = 10^-18 (10^-18 USD)/(10^-36 USD)
        // So divide the whole thing with 10^18:
        // !!! always do division by big numbers at last. If you do _ethAmount / 10 ** 18 * ethPrice, will return zero!! 
        return _ethAmount * ethPrice / (10 ** 18);
    }

    /* SafeMath, division by zero and overflow */
    // Overflow exmaple:
    // uint8 overflow = 255 + 1 <= Solidity will check if the number to be assigned is bigger than what uint8 can hold, throws compile error
    // uint8 overflow = 255 + uint8(1) <= Solidity will still let it pass compiling, then OVERFLOW and WRAP while running! overflow == 0 now.
    // To prevent default wrapping behaviour, use the pre-written "SafeMath" library from OpenZeppelin
    // - SafeMath functions will REVERT if arithmetic overflows/underflows 
    // - Example of importing such libraries is stated at the top of this file
    // - !!! As of 0.8.0, the compiler has built-in overflow revert in RUNTIME too so no need SafeMath anymore ((!!! but still not giving warning for the above case during compile time. See "test.sol"))
    // Division by zero:
    // (As of 22 Apr 2022) Division by zero will result in an "invalid opcode" error.
    //
    // ** See the next notes to see how to use a LIBRARY

}