---
tags: ["intro"]
---

The [x/wasm module](https://github.com/CosmWasm/wasmd/tree/main/x/wasm), the root of CosmWasm, is a
[Cosmos SDK](https://docs.cosmos.network/) module enabling smart contracts to execute on the Wasm virtual machine.
It is a bridge between Cosmos chain and the [WasmWM](https://github.com/CosmWasm/wasmvm) executing the smart contracts.
CosmWasm itself is the whole ecosystem built around it with a mission to make smart contracts development easy and reliable.
The focuses of the CosmWasm platform are security, performance, and interoperability. CosmWasm is the only smart contracts
platform for public blockchains that has been heavily adopted outside the EVM world.

We chose to target a Rust programming language as a Smart Contract development stack, as it has the best Wasm compiler on the
market so far. As of today, we do not provide bindings to help write Smart Contracts in another stack that compiles to Wasm,
and we don't support that.

Here is where to find CosmWasm in the whole Cosmos stack:

```mermaid
erDiagram
    "Cosmos SDK" ||--|| BFT: Uses
    "Cosmos SDK" ||--|| "Wasm/WasmWM": Includes
    "Cosmos SDK" ||--o{ "Custom Module" : Includes
    "Wasm/WasmWM" ||--o{ "Smart Contract": Executes

```

The important thing about CosmWasm smart contracts is their transparency. Even though they are executed by the chain node application
using the WasmVM module, they are written to hide their dependency on it. Every smart contract instance has its unique address on the chain,
and it can act just like any other chain client. It is easy to implement communication between two smart contracts on the same chain.
CosmWasm standard library provides simple utilities to communicate with non-CosmWasm modules on the chain. That includes common Cosmos
modules like bank or staking and any custom module unique for a particular chain. Finally, CosmWasm is built around the
[IBC](https://www.ibcprotocol.dev/), and it
provides simple entities for communication with remote chains using IBC-based protocols and talk directly to smart contracts instantiated
on remote chains with the IBC packages.

This documentation already covers most of the stack. Still, some parts are a work in progress. If there is something you remember
being here in the old documentation, you can find its content at https://github.com/CosmWasm/docs-deprecated. Remember that the
old documentation is deprecated, mostly outdated, and will not be maintained. We would appreciate any GitHub issues about missing
parts in the [documentation repository](https://github.com/CosmWasm/docs).

It is worth noting about additional CosmWasm learning resources:

- [CosmWasm book](https://book.cosmwasm.com/)
- [Sylvia book](https://cosmwasm.github.io/sylvia-book/index.html)
