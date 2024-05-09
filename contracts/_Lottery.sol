// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;


contract Lottery { 
    address public owner;
    address payable[] public players;
    constructor()  { 
        owner = msg.sender;
    }

    function getBalance() public view returns (uint) { 
        return address(this).balance;
    }

    function getPlayers() public view returns (address payable[] memory) { 
        return players;
    }

    function enter() public payable { 
        require(msg.value > 0.01 ether);
        players.push(payable(msg.sender));
    }

    function getRandomNumber() public view returns (uint) { 
        return uint(keccak256(abi.encodePacked(owner, block.timestamp)));
    }

    function pickWinner() public onlyOwner { 
        uint index = getRandomNumber() % players.length;
        players[index].transfer(address(this).balance);


        // reset the state of the contract
        delete players;
    }
    modifier onlyOwner() { 
        require(msg.sender == owner);
        _;
    } 
}