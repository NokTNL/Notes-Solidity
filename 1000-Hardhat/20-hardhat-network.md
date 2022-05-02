- e.g. When you run `npx hardhat run` to test deployment & scripts, a new instance of Hardhat Network will always be set up and dies when your script is finished.
- You can, however, set up a standalone Hardhat Netowork in runtime that will persist: `npx hardhat node`
- This will expose an URL for you to connect to this local network (`http://localhost:8545` or `http://127.0.0.1:8545/`)

- To run scripts against this standalone network, use `npx hardhat run scripts/sample-script.js --network localhost`
- You will see the transactions inside the Hardhat Netowork node accordingly.
