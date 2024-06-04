# Introduction

Not being able to persist data across calls would limit the utility of smart
contracts. How could a smart contract

- implement a token if it could not keep track of balances,
- implement a voting system if it could not keep track of votes, or
- implement a game if it could not keep track of scores?

This is why a _CosmWasm_ smart contract has access to the storage facilities
offered by the _Cosmos SDK_. These facilities are essentially a binary key-value
store, with records stored on-chain.

## Storage limits

While developing smart contracts, it's important to remember on-chain storage
is, as always, pricey. Conventionally, developers often draw the line at a
"small logo image" (think a few KBs). If you need to store bigger things, it's
likely time to consider off-chain storage (like IPFS or some centralized storage).
Techniques for securely and reliably storing large data off-chain are beyond the
scope of this document.

Trying to minimize bloat is always good practice when it comes to on-chain
storage.

## What _cw-storage-plus_ builds on

The smart contract framework itself (_cosmwasm-std_) provides a simple API for
storing and retrieving data. If you're curious, you can check it out right
[here](https://docs.rs/cosmwasm-std/2.0.3/cosmwasm_std/trait.Storage.html).

This API is raw in that it exposes the **binary** key-value store. While you're
free to use it directly, you're likely to find that finicky and error-prone.
_cw-storage-plus_ is a library that builds on top of this API to

- eliminate the need to manually serialize and deserialize data,
- provide a type-safe interface for storing and retrieving data,
- help manage keys, and
- provide featureful persistent data structures.

Let's explore!
