pragma solidity ^0.8.20;

contract Counter{
  uint256 public count ;
  address public owner;

  constructor(){
    owner = mensage.sender;
  }

  function  increment (uint256 amount) public{
    require( msg.sender == owner, "only the owner can increment");
    require(amount > 0, "amount must be greater than zero");

    count += amount;
  }

  function  decrement (uint256 amount) public{
    require( msg.sender == owner, "only the owner can decrement");
    require(count >= amount,"Counter shall not go under 0");
    require(amount > 0, "amount must be greater than zero");

    count -= amount;

    emit Decrement(msg.sender, amount, count);
  }

  function reset public(){
    require(msg.sender == owner, "only the owner can reset");
    count = 0;

    emit Reset(msg.sender);
  }
