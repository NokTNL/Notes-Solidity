pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {
    /* Math operations */
    // Solidity has six: +, - , *, /, % (modulus), ** (exponential)

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    /* hashing by keccak256 */
    // It accepts bytes type input and returns bytes32 hex number
    // !! Don't rely on it as a secure random number gen in real world application
    bytes32 public myHash = keccak256("cat");
    // A typical use: pack multiple strings into a single (dynamic) bytes and hash it with keccak256
    bytes32 public myHash2 = keccak256(abi.encodePacked("abcs", "asidajs43BBI"));

    // Typecasting: conversion between different types
    // https://docs.soliditylang.org/en/v0.5.3/types.html#conversions-between-elementary-types
    // Implicit conversion: done when operator accepts inputs of different types. The compiler tries to avoid any info lost
    // e.g. uint * uint8 => uint
    // The actual final type varies depending on individual types
    // Explicit conversion: you force Solidity to do conversion for you, example:
    uint8 a = 5;
    uint b = 6;
    // throws an error because a * b returns a uint, not uint8:
    uint8 c = a * b;
    // we have to typecast b as a uint8 to make it work, using uint8():
    uint8 c = a * uint8(b);
}