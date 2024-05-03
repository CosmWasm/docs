# Introduction

[**CosmWasm MultiTest**](https://github.com/CosmWasm/cw-multi-test) is a suite
of testing tools designed for facilitating multi-contract interactions within
the [CosmWasm](https://github.com/CosmWasm) ecosystem. Its primary focus is on
providing developers with a robust framework for _simulating_ complex contract
interactions and several [Cosmos](https://docs.cosmos.network/) modules
operations.

[MultiTest](https://github.com/CosmWasm/cw-multi-test) enables comprehensive
unit testing, including scenarios where contracts call other contracts and
interact with
[Cosmos modules](https://docs.cosmos.network/v0.50/learn/intro/sdk-design#modules).

[MultiTest](https://github.com/CosmWasm/cw-multi-test) is a _simulation_ of the
blockchain, allowing tested smart contracts to interact as if they were
operating on the real-life blockchain. Such an approach naturally has its
advantages and disadvantages.

The most valuable advantage of using
[MultiTest](https://github.com/CosmWasm/cw-multi-test) is that it allows you to
test and debug smart contracts with access to Rust source code, eliminating the
need to run a complete blockchain node to begin designing smart contract
functionality.

The disadvantage is that [MultiTest](https://github.com/CosmWasm/cw-multi-test)
only _simulates_ the real-life blockchain, and it is possible that the behavior
of the real-life blockchain may slightly differ in edge cases from the simulated
model. In such cases, we strongly encourage users to
[file an issue](https://github.com/CosmWasm/cw-multi-test/issues) with a
detailed description of the use case to help us improve
[MultiTest](https://github.com/CosmWasm/cw-multi-test).

In the upcoming chapters, we will provide detailed instructions on installing
and getting started with [MultiTest](https://github.com/CosmWasm/cw-multi-test),
writing unit tests for smart contracts, testing complex interactions between
smart contracts and testing smart contract interactions with
[Cosmos modules](https://docs.cosmos.network/v0.50/learn/intro/sdk-design#modules).
Additionally, we'll explore how to effectively write unit tests to validate the
functionality of individual smart contracts and demonstrate techniques for
testing complex interactions where multiple smart contracts interact with each
other. By the end of these chapters, you will have a comprehensive understanding
of using [MultiTest](https://github.com/CosmWasm/cw-multi-test) for testing and
debugging smart contracts in various scenarios.

---

Topics to cover:

- ✅ [Installation](multitest/installation) (1)
- 🚧 [Getting started](multitest/getting-started) (2)
- [ ] ? (3)
- [ ] ? (4)
- [ ] ? (5)
- [ ] ? (6)
- [ ] ? (7)
- [ ] ? (8)
- [ ] ? (9)
- [ ] ? (10)
- [ ] ? (11)
- [ ] ? (12)
- 🚧 [Testing KPIs](/multitest/miscellaneous/testing-kpis) (13)
- 🚧 [Black-box testing](/multitest/miscellaneous/black-box-testing) (14)
- 🚧 [Testing shallot](/multitest/miscellaneous/testing-shallot) (15)
