# Installation

## cw-multi-test

[CosmWasm MultiTest](https://github.com/CosmWasm/cw-multi-test) ships as a Rust
library named [**cw-multi-test**](https://crates.io/crates/cw-multi-test).

To use [**cw-multi-test**](https://crates.io/crates/cw-multi-test) for building
and testing smart contracts, just add it as a development dependency to
`Cargo.toml` file like shown below:

```toml
[dev-dependencies]
cw-multi-test = "2"
```

## Rust and Cargo

The only requirement to build smart contracts and test them using
[**cw-multi-test**](https://crates.io/crates/cw-multi-test) is having
[Rust and Cargo](https://www.rust-lang.org/tools/install) installed.

## Tarpaulin

Optionally, you may want to install
[Tarpaulin](https://github.com/xd009642/tarpaulin) for measuring code coverage:

```shell
cargo install cargo-tarpaulin
```

## cargo-nextest

You may also optionally install [cargo-nextest](https://nexte.st) for running
tests faster, with clean and beautiful user interface:

```shell
cargo install cargo-nextest
```
