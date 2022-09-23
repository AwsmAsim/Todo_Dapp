module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*" // Match any network id
    }
  },
  contracts_build_directory: "./src/artifacts/",
  solc: {
    version: "0.8.13",
    optimizer: {
      enabled: true,
      runs: 200,
      details: {
        yul: false
      }
    }
  }

//solidity: {
//    compilers: [
//      {
//        version: "0.7.6",
//        settings: {
//          optimizer: {
//            enabled: true,
//            runs: 500,
//            yul: true
//          },
//        },
//      },
//      {
//        version: "0.8.13",
//        settings: {
//          metadata: {
//            // Not including the metadata hash
//            // https://github.com/paulrberg/solidity-template/issues/31
//            bytecodeHash: "none",
//          },
//          optimizer: {
//            enabled: true,
//            runs: 800,
//            yul: true
//          },
//          viaIR : true,
//        },
//      },
//    ],
//  },
//solidity: {
//    version: "0.8.11",
//    settings: {
//      optimizer: {
//        runs: 200,
//        enabled: true,
//        details: {
//          yul: false
//        }
//      },
//    },
//  },
}