pragma solidity  >=0.5.0 <0.6.0;

contract ZombieFactory {
    // Controlling the length of our DNA
    uint dnaDigits = 16;
    // We only need 16-digits decimal number, so we will take modulo over 10^16:
    uint dnaModulus = 10 ** dnaDigits;

    // Every zombie has a name and a DNA
    struct Zombie {
        string name;
        uint dna;
    }
    // DB of all our zombies
    Zombie[] public zombies;

    // Define an event telling the fron-end a new zombie is pushed into Zombie
    event NewZombie(uint zombieId, string name, uint dna);

    // Generate a random DNA
    function _generateRandomDna(string memory _str) private view returns (uint) {
        // Explicit type coversion as keccak256 returns bytes32
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    // Add a new zombie into the Zombies array, given name and DNA
    function _createZombie(string memory _name, uint _dna) private {
        // array.push returns the latest LENGTH of the array
        // !!! Not true anymore from 0.6.0, access array length using array.length
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        emit NewZombie(id, _name, _dna);
    }
    
    // Combine the above two functions and make it visible to public:
    function createRandomZombie(string memory _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}