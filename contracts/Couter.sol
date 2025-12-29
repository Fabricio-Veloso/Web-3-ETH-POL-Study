pragma solidity ^0.8.20;

contract counter{
  uint256 count public;
  count = 0;

  function increment(uint256 amount){
    if(msg.sender == owner(this)){
      count += amount;
    }
  }

  function decrement(uint256 amount){
    if (count == 0)  {
      {
        return;
      }
      else{
        if (msg.sender == owner(this))) {
          count -= amount;
        } 
      }

    }
  }
