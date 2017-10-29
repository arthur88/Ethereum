pragma solidity ^0.4.4;

contract Adoption {
    address[16] public adopters;

    /*
    types of both the function parameters and output must be specified. In this case we'll be taking in a petId (integer) and returning an integer.
    */ 
    function adopt(uint petId) public returns (uint) {
       // require(petId >= 0 && petId <= 15);

        adopters[petId] = msg.sender;

        return petId;
    }

    /* making 16 API calls is not ideal. So our next step is to write a function to return the entire array. */
    function getAdopters() public returns (address[16]) {
        return adopters;
    }
}
