/// SPDX-License-Identifier: Universal Permissive License v1.0
/// @custom:org.security.mailto='ops@manifoldfinance.com'
/// @custom:org.security.policy=' https://github.com/manifoldfinance/security'
/// @custom:org.security.vcs-url='github.com/manifoldfinance'
/// @custom:org.security.encryption='https://flowcrypt.com/pub/sam@manifoldfinance.com'
/// @custom:org.security.schema-version="2023-08-10T07:40:14-0700"
pragma solidity ^0.8.19;

import "../MevEthTest.sol";
import { IStakingModule } from "../../src/interfaces/IStakingModule.sol";

contract MevValidatorRefundTest is MevEthTest {
    function testGrantValidatorWithdraw() public {
        uint256 amount = 32 ether;
        address staker = address(mevEth.stakingModule());

        vm.deal(address(this), amount);
        payable(staker).transfer(amount);

        uint256 elastic = mevEth.totalAssets();
        uint256 base = mevEth.totalSupply();

        vm.expectEmit();
        emit ValidatorWithdraw(staker, amount);
        vm.prank(SamBacha);
        IStakingModule(staker).payValidatorWithdraw(amount);

        assertEq(elastic, mevEth.totalAssets());
        assertEq(base, mevEth.totalSupply());
    }
}
