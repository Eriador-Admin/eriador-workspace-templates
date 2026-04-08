// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Counter {
    uint256 public number;

    event NumberChanged(uint256 oldNumber, uint256 newNumber);

    function setNumber(uint256 newNumber) public {
        uint256 oldNumber = number;
        number = newNumber;
        emit NumberChanged(oldNumber, newNumber);
    }

    function increment() public {
        uint256 oldNumber = number;
        number++;
        emit NumberChanged(oldNumber, number);
    }

    function decrement() public {
        require(number > 0, "Counter: cannot decrement below zero");
        uint256 oldNumber = number;
        number--;
        emit NumberChanged(oldNumber, number);
    }
}
