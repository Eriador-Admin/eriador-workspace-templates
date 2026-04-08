// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/SimpleToken.sol";

contract SimpleTokenTest is Test {
    SimpleToken public token;
    address public alice = makeAddr("alice");
    address public bob = makeAddr("bob");
    uint256 public constant INITIAL_SUPPLY = 1_000_000;

    function setUp() public {
        token = new SimpleToken("Test Token", "TST", INITIAL_SUPPLY);
    }

    function test_InitialState() public view {
        assertEq(token.name(), "Test Token");
        assertEq(token.symbol(), "TST");
        assertEq(token.decimals(), 18);
        assertEq(token.totalSupply(), INITIAL_SUPPLY * 1e18);
        assertEq(token.balanceOf(address(this)), INITIAL_SUPPLY * 1e18);
    }

    function test_Transfer() public {
        uint256 amount = 100 * 1e18;
        token.transfer(alice, amount);
        assertEq(token.balanceOf(alice), amount);
        assertEq(token.balanceOf(address(this)), (INITIAL_SUPPLY * 1e18) - amount);
    }

    function test_RevertTransferInsufficientBalance() public {
        vm.prank(alice);
        vm.expectRevert("SimpleToken: insufficient balance");
        token.transfer(bob, 1);
    }

    function test_RevertTransferToZeroAddress() public {
        vm.expectRevert("SimpleToken: transfer to zero address");
        token.transfer(address(0), 1);
    }

    function test_ApproveAndTransferFrom() public {
        uint256 amount = 50 * 1e18;
        token.approve(alice, amount);
        assertEq(token.allowance(address(this), alice), amount);

        vm.prank(alice);
        token.transferFrom(address(this), bob, amount);
        assertEq(token.balanceOf(bob), amount);
    }

    function test_RevertTransferFromInsufficientAllowance() public {
        token.approve(alice, 10);
        vm.prank(alice);
        vm.expectRevert("SimpleToken: insufficient allowance");
        token.transferFrom(address(this), bob, 100);
    }
}
