pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {

    // A front-end app don't know what is hapenning in a contract
    // By the help of front-end libraries, the app can listen to a contract's EVENTS

    // declare our event name and name the variables to be attached to the event when emitted
    event IntegersAdded(uint x, uint y, uint result);

    function add(uint _x, uint _y) public returns (uint) {
        uint result = _x + _y;
        // fire the event decalred above to let the front-end know something happenned:
        emit IntegersAdded(_x, _y, result);
        return result;
    }

    // In a JavaScript front-end app, it can listen to the event like this:
    /* 
        YourContract.IntegersAdded(function(error, result) {
            // do something with result
        })
    */
}
