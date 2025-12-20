import { expect } from "chai";
import { network } from "hardhat";

const { ethers } = await network.connect();

describe("Reentrancy attack", function () {
  it("drains the vulnerable vault", async function () {
    const [deployer, attackerEOA] = await ethers.getSigners();

    // Deploy vault
    const Vault = await ethers.getContractFactory("VulnerableVault");
    const vault = await Vault.deploy();

    // Fund vault with 10 ETH
    await vault.deposit({ value: ethers.parseEther("10") });

    expect(await ethers.provider.getBalance(vault.target)).to.equal(
      ethers.parseEther("10")
    );

    // Deploy attacker contract
    const Attacker = await ethers.getContractFactory("Attacker", attackerEOA);
    const attacker = await Attacker.deploy(vault.target);

    // Attack with 1 ETH
    await attacker.attack({ value: ethers.parseEther("1") });

    const vaultBalance = await ethers.provider.getBalance(vault.target);
    const attackerBalance = await ethers.provider.getBalance(attacker.target);

    console.log("Vault balance:", ethers.formatEther(vaultBalance));
    console.log("Attacker balance:", ethers.formatEther(attackerBalance));

    expect(vaultBalance).to.equal(0n);
    expect(attackerBalance).to.be.gt(ethers.parseEther("10"));
  });
});
