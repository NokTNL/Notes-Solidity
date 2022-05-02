This is copied from Practice05v2 in "60-CryptoZombies..." folder, plus some changes to test in Hardhat.

Changes:

- **!!! Fix serious bug: Lottery.placeBet had `_accountDebit` and `_accountCredit` mixed up**

- Make event for returning "Win" or "Lose" result in LimitedLottery.placeBet

- The "TimeLimitedLottery" contract is deployed on the Rinkeby testnet: `0x893E95e4A02D56Af2B7Bfa4386D9B7F583C1C4B6`
