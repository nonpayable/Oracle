// SPDX-License-Identifier: MIT

pragma solidity >= 0.8.0;

contract Oracle{
    event getRequest(string API);
    address owner;
    // change 'value' to whatever type you want
    // also change setValue() and onlyCallback() _value parameter type
    string[] private value;
    mapping(address => bool) authorized; 

    constructor(){
        owner = msg.sender;
        authorized[msg.sender] = true;
    }

    modifier isAuth() {
        require(authorized[msg.sender], "No permission!");
        _;
    }
    // Authorize to use orcale
    function auth(address who) external{
        require(msg.sender == owner,"Sender is not owner!");
        authorized[who] = true;
    }

    // Revoke permission to use oracle
    function revoke(address who) external{
        require(msg.sender == owner,"Sender is not owner!");
        authorized[who] = false;
    }

    // emit event
    // off-chain subscribe to this event
    // off-chain make http request to requested url
    // off-chain call setValue with ^'s response.
    function getValue(string calldata url) external isAuth{
        emit getRequest(url);
    }

    function setValue(string[] memory _value) external isAuth{
        value = _value;
    }

    // calling other contract(callback) with value from requested url from getValue
    function setValue(string[] memory _value, address callback, string calldata _abi) external isAuth{
        value = _value;
        (bool success, ) = callback.call(abi.encodeWithSignature(_abi, _value));
        require(success,"Failed!");
    }

    // setValue() with callback but without setting any value.
    function onlyCallback(string[] memory _value, address callback, string calldata _abi) external isAuth{
        (bool success, ) = callback.call(abi.encodeWithSignature(_abi, _value));
        require(success,"Failed!");
    }
}
