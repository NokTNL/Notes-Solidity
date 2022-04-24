const metadata = {
  compiler: {
    version: "0.6.12+commit.27d51765",
  },
  language: "Solidity",
  output: {
    abi: [
      {
        inputs: [],
        stateMutability: "payable",
        type: "constructor",
      },
      {
        inputs: [
          {
            internalType: "uint256",
            name: "_wei",
            type: "uint256",
          },
        ],
        name: "WeiToUsd",
        outputs: [
          {
            internalType: "uint256",
            name: "",
            type: "uint256",
          },
        ],
        stateMutability: "view",
        type: "function",
      },
      {
        inputs: [],
        name: "donateToBank",
        outputs: [],
        stateMutability: "payable",
        type: "function",
      },
      {
        inputs: [],
        name: "ownerCheckUnreadyAddr",
        outputs: [
          {
            internalType: "address[]",
            name: "",
            type: "address[]",
          },
          {
            internalType: "uint256",
            name: "",
            type: "uint256",
          },
        ],
        stateMutability: "view",
        type: "function",
      },
      {
        inputs: [],
        name: "ownerViewBankPool",
        outputs: [
          {
            internalType: "uint256",
            name: "",
            type: "uint256",
          },
        ],
        stateMutability: "view",
        type: "function",
      },
      {
        inputs: [
          {
            internalType: "uint256",
            name: "_betAmount",
            type: "uint256",
          },
        ],
        name: "placeTimeLimitedBet",
        outputs: [],
        stateMutability: "nonpayable",
        type: "function",
      },
      {
        inputs: [],
        name: "playerDepositFund",
        outputs: [],
        stateMutability: "payable",
        type: "function",
      },
      {
        inputs: [],
        name: "playerViewFund",
        outputs: [
          {
            internalType: "uint256",
            name: "",
            type: "uint256",
          },
        ],
        stateMutability: "view",
        type: "function",
      },
      {
        inputs: [
          {
            internalType: "uint256",
            name: "_amount",
            type: "uint256",
          },
        ],
        name: "playerWithdrawFund",
        outputs: [],
        stateMutability: "nonpayable",
        type: "function",
      },
      {
        inputs: [
          {
            internalType: "uint256",
            name: "_usd",
            type: "uint256",
          },
        ],
        name: "usdToWei",
        outputs: [
          {
            internalType: "uint256",
            name: "",
            type: "uint256",
          },
        ],
        stateMutability: "view",
        type: "function",
      },
    ],
    devdoc: {
      kind: "dev",
      methods: {},
      version: 1,
    },
    userdoc: {
      kind: "user",
      methods: {},
      version: 1,
    },
  },
  settings: {
    compilationTarget: {
      "50-PatrickCollins-03-FundMe-Oracles/Practice05/TimeLimitedLottery.sol":
        "TimeLimitedLottery",
    },
    evmVersion: "istanbul",
    libraries: {},
    metadata: {
      bytecodeHash: "ipfs",
    },
    optimizer: {
      enabled: false,
      runs: 200,
    },
    remappings: [],
  },
  sources: {
    "50-PatrickCollins-03-FundMe-Oracles/Practice05/Lottery.sol": {
      keccak256:
        "0x539d8c93e4cb3a186953ae58607b4c598e7bf1f16f329bf7f4ff71a886d4c7fe",
      license: "MIT",
      urls: [
        "bzz-raw://3036b97a1fa4ac303ad1597420c41fb8d204d66b8eeb17879b6364cc2e3887c7",
        "dweb:/ipfs/QmUjvZem9PdUGMDx9X9GCaCt9eDKcGStf5kTDtACKfehPv",
      ],
    },
    "50-PatrickCollins-03-FundMe-Oracles/Practice05/Ownable.sol": {
      keccak256:
        "0x149e7ed32a5755d5f3fe51d42b6035b158405a788eefeeba466dc995fcd64595",
      license: "MIT",
      urls: [
        "bzz-raw://f4cc8405f7739f7077d851193f6f8027dce378401188372c1595d6acb36827d9",
        "dweb:/ipfs/QmY421TxknGbs7G2tnDys5Nk3yJFmYXQSgRuiwQ5eXA7vU",
      ],
    },
    "50-PatrickCollins-03-FundMe-Oracles/Practice05/PriceFeed.sol": {
      keccak256:
        "0x34e440051b08ea167ac1bd43d29302cf0e08175914065bb141df8a7bae5e09c6",
      license: "MIT",
      urls: [
        "bzz-raw://c85a3d39e98ed9eb76f022bf20d4e3a0fd9d8a76f18191f150ba2510261ef48b",
        "dweb:/ipfs/QmUUKrkBAWczncUcNMgwDM5fbGQwTLR8YSVKFUDDCVY3Gn",
      ],
    },
    "50-PatrickCollins-03-FundMe-Oracles/Practice05/SecureBank.sol": {
      keccak256:
        "0x04535f6ad137b37a1c085b99ba34e8c0411ffcd4f773810305b9f75c176b1058",
      license: "MIT",
      urls: [
        "bzz-raw://a6568b537905b720d941e5904d0ef0eb4180b435bd18e1b208bad79e94403a18",
        "dweb:/ipfs/Qmd3pzeb6gK1rVapvY3YuCp6848bW4nmwsCyT8toWp3WtH",
      ],
    },
    "50-PatrickCollins-03-FundMe-Oracles/Practice05/TimeLimitedLottery.sol": {
      keccak256:
        "0x2abfd30a9920f01600ce0c3ac03dac64fc21fbd94f945724127fc392055aa3b0",
      license: "MIT",
      urls: [
        "bzz-raw://24c8514134113c06665ec10863acac4e4ce47c0f8fb824093c03d8e97596923c",
        "dweb:/ipfs/QmSdgxmRPWzX3ZfcMFtch6q7tvkU8a4G5kvUCR3mdZ4nf5",
      ],
    },
    "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol": {
      keccak256:
        "0x8895ce4f46aba18ee3cdb7b1d180f79edb868225781f60993c7b2181e2ee2583",
      license: "MIT",
      urls: [
        "bzz-raw://4472c14df5f311d7a2eff1dfa55d9b4d39a21b0a0ff905fcbbf6913551086a4c",
        "dweb:/ipfs/QmQvwFk1SBaLMm4pmZCz7UEhfaXM8kUWu5VG71VFFuMxjF",
      ],
    },
  },
  version: 1,
};

export { metadata };
