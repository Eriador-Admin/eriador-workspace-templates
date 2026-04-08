// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/Counter.sol";
import "../src/SimpleToken.sol";

contract DeployScript is Script {
    function run() public {
        uint256 deployerKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerKey);

        Counter counter = new Counter();
        console.log("Counter deployed at:", address(counter));

        SimpleToken token = new SimpleToken("My Token", "MTK", 1_000_000);
        console.log("SimpleToken deployed at:", address(token));

        vm.stopBroadcast();
    }
}
