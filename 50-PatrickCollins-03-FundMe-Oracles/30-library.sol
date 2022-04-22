// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

// The following library is adapted from here: https://github.com/smartcontractkit/chainlink/blob/develop/contracts/src/v0.6/vendor/SafeMathChainlink.sol

/* Library */
// A library in Solidity is similar to a contract, with some differences:
// - it is STATELESS, so you can't have state variables declared in it
// - can only change another contract's state if it is explicitly supplied (as a paramter)
// - does not own "this": when its methods are called, "this" points to the contract where its functions are called (as "this" points to a CONTRACT instance)
library SafeMathChainlink {
  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    require(c >= a, "SafeMath: addition overflow");

    return c;
  }
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    require(b <= a, "SafeMath: subtraction overflow");
    uint256 c = a - b;

    return c;
  }
  // ... the remaining code is omitted for simplicity
}

// To use a library, call its functions like an object:
contract Tutorial {

  uint public myNum = SafeMathChainlink.add(100, 200); // will return 300 as expected

  /* The "using" keyword */
  // "using" attach a library to a type !
  // Sounds weird. An example:
  using SafeMathChainlink for uint;
  // Variables declared as uint256 now have the library's functions as its MEMBERS.
  // When the member functions are called, the  object calling it will be passed as the FIRST PARAMETER of the function.
  // Therefore you can do this now:
  uint public myNum2 = 300;
  function increaseMyNum2() public view returns(uint) {
    return myNum2.add(100);
  }
  // or even this:
  uint public myNum3 = uint(300).add(100);
  //                   ^ this is an uint too!

  // Note: below set all types to use the library's functions:
  // using SafeMathChainlink for *;


}
