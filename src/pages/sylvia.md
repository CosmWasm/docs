# Introduction to Sylvia

Sylvia is a framework for building CosmWasm smart contracts with a high level of
abstraction.

It's built on top of crates such as `cosmwasm-std` and `cw-multi-test`.

It allows the users to focus purely on business logic by generating message
structures, specifying how their API is (de)serialized, or how to handle message
dispatching. Instead, the API of your contract is a set of traits you implement
on your contract type.

The framework generates things like entry point structures, functions
dispatching the messages, or even helpers for **MultiTest**. It allows for
better control of interfaces, including validating their completeness in compile
time.
