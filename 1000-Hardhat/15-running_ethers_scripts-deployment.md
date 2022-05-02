## Running scripts & deployment

You typically deploy your contracts by running SCRIPTS: `npx hardhat run <path-to-script-file>`.

- Whenever you run `npx hardhat run`, it will always run the `compile` task first.

- The script is TYPICALLY run using hardhat-ethers (extended from ethers.js): https://hardhat.org/plugins/nomiclabs-hardhat-ethers.html

**Take a look at the sample scripts file in the `scripts` folder. Has thorough guide on how to use ethers.js to deploy and call contracts.**

- `npx hardhat run` always includes the `hardhat` library for you to use in your scripts already. If you want to run the script using Node.js instead:

1.  include:

```
const hre = require("hardhat");
const ethers = hre.ethers;
```

in your scripts, then run `node <path-to-script-file>`. 2. You also need to make sure you have compiled the contracts before deploying. Refer to `scripts/sample-script.js`
