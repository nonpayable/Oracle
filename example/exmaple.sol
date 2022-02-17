// SPDX-License-Identifier: MIT

pragma solidity >= 0.8.0;

import "../oracle.sol";

contract somecontract{
    // deployed oracle.sol
    Oracle oracle = Oracle(0x0000000000000000000000000000000000000000);

    string[] LondonDate;

    function __callback(string[] memory value) external{
        require(msg.sender == address(oracle));
        LondonDate = value;
    } 

    function check() external view returns(string[] memory){
        return LondonDate;
    }

    function get(string calldata url) external{
        // request oralce
        oracle.getValue(url);
    }
}
