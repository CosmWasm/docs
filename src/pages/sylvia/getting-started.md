# Getting started

To work with CosmWasm smart contract, you will need Rust installed on your
machine. If you don't have one, you can find installation instructions on
[the Rust website](https://www.rust-lang.org/tools/install).

We assume you are working with a stable Rust channel in this book.

Additionally, you will need the **Wasm** Rust compiler backend installed to
build Wasm binaries. To install it, run the following:

```shell
$ rustup target add wasm32-unknown-unknown
```

## Check contract utility

An additional helpful tool for building smart contracts is the
[`cosmwasm-check`](https://crates.io/crates/cosmwasm-check) utility. It allows
you to check if the wasm binary is a proper smart contract ready to upload into
the blockchain. You can install it using cargo:

```shell
$ cargo install cosmwasm-check
```

If the installation succeeds, you can execute the utility from your command
line.

```shell
$ cosmwasm-check --version
Contract checking 2.0.2
```

## Verifying the installation

To guarantee you are ready to build your smart contracts, you must ensure you
can build examples. Checkout the [sylvia](https://github.com/CosmWasm/sylvia)
repository and run the testing command in its folder:

```shell
$ git clone https://github.com/CosmWasm/sylvia.git
$ cd sylvia
sylvia $ cargo test
```

You should see that everything in the repository gets compiled and all tests
pass.

Sylvia framework contains some examples of contracts. To find them go to
`examples/contracts` directory. These contracts are maintained by CosmWasm
creators, so contracts in there should follow good practices.

To verify contract using the `cosmwasm-check` utility, first you need to build a
smart contract. Go to some contract directory, for example,
`examples/contracts/cw1-whitelist`, and run the following commands:

```shell
sylvia $ cd examples/contracts/cw1-whitelist
sylvia/examples/contracts/cw1-whitelist $ cargo wasm
```

`wasm` is a cargo alias for
`build --release --target wasm32-unknown-unknown --lib`. You should be able to
find your output binary in the `examples/target/wasm32-unknown-unknown/release/`
of the root repo directory, not in the contract directory itself! Now you can
check if contract validation passes:

```shell
sylvia $ cosmwasm-check examples/target/wasm32-unknown-unknown/release/cw1_whitelist.wasm

Available capabilities: {"iterator", "cosmwasm_2_0", "cosmwasm_1_1", "cosmwasm_1_2", "staking", "stargate", "cosmwasm_1_3", "cosmwasm_1_4"}

target/wasm32-unknown-unknown/release/cw1_whitelist.wasm: pass

All contracts (1) passed checks!
```

## Macro expansion

Sylvia generates a lot of code for us, which is not visible right away. To see
the generated code, go to `examples/contracts/cw1-whitelist/src/contract.rs`.

In VSCode you can click on `#[contract]`, do `shift+p` and then type:
`rust analyzer: Expand macro recursively`. This will open a window with a fully
expanded macro, which you can browse.

In Vim you can consider installing the
[rustaceanvim](https://github.com/mrcjkb/rustaceanvim) plugin.

You can also use `cargo expand` tool from CLI, like this:

```shell
sylvia/examples/contracts/cw1-whitelist $ cargo expand --lib
```
