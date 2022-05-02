const hre = require("hardhat");

async function setTimeoutPromise(time) {
  await new Promise((resolve) => {
    setTimeout(() => {
      resolve();
    }, time);
  });
}

async function main() {
  /*
   * Contract Deployment
   */
  const tll_factory = await hre.ethers.getContractFactory("TimeLimitedLottery");
  // This contract needs value sent when constructed. Pass the additional "value" property as an OVERRIDE OBJECT:
  // https://docs.ethers.io/v5/api/contract/contract-factory/#ContractFactory-deploy

  console.log("Deploying contract...");
  const lotteryContract = await tll_factory.deploy({
    value: ethers.utils.parseUnits("1", "gwei"),
  });
  await lotteryContract.deployTransaction.wait(1);
  console.log(`Contract deployed, address: ${lotteryContract.address}`);

  /*
   * Calling functions
   */
  // Read-only function
  let myFund = await lotteryContract.playerViewFund();
  console.log(`My fund: ${myFund}`);
  // Writing function
  const depositValue = "1000000000";
  const depositResponse = await lotteryContract.playerDepositFund({
    value: depositValue,
  });
  const depositReceipt = await depositResponse.wait();
  console.log("Deposit succesful");

  myFund = await lotteryContract.playerViewFund();
  console.log(`My fund: ${myFund}`);

  /*
   * Testing more complicated functions
   */
  try {
    // Placing the bet
    await betAndCheckFund();

    // Placing the bet again
    /* console.log("Waiting until cooldown time has passed...");
    await setTimeoutPromise(30000);
    // Below will fail as not waiting for 30 seconds, unless the setTimeoutPromise code above is run
    await betAndCheckFund(); */

    // Withdrawing funds
    // - Below will fail if much bigger than initial `depositValue`
    const { BigNumber } = hre.ethers;
    const B_depositValue = BigNumber.from(depositValue);
    const tx = await lotteryContract.playerWithdrawFund(
      B_depositValue.div("10")
    );
    await tx.wait(1);
    console.log(`Fund withdrawn from account`);
    // Check remaining fund
    myFund = await lotteryContract.playerViewFund();
    console.log(`My fund: ${myFund}`);
    /*
     * End
     */
  } catch (error) {
    console.error(error.message);
  }

  async function betAndCheckFund() {
    let tx, receipt;
    tx = await lotteryContract.placeTimeLimitedBet("10000");
    receipt = await tx.wait(1);
    console.log(receipt.events[0].args.result);
    // See the updated account fund
    console.log(`My fund: ${await lotteryContract.playerViewFund()}`);
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
