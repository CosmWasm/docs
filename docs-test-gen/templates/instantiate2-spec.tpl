#![allow(unexpected_cfgs, dead_code, unused_variables, unused_imports)]

use sha2::{Digest, Sha256};
use cosmwasm_std::{Api, testing::*};

macro_rules! concat {
    ($($item:expr),+$(,)?) => {{
        let mut acc = Vec::new();
        $(
            acc.extend({ $item });
        )*
        acc
    }};
}

fn hash_sha256(input: impl AsRef<[u8]>) -> Vec<u8> {
    Sha256::digest(input).to_vec()
}

#[test]
fn doctest() {
    let deps = mock_dependencies();

    let msg = b"";
    let salt = b"salty :D";

    let canon_creator = deps.api.addr_canonicalize("cosmwasm1h34lmpywh4upnjdg90cjf4j70aee6z8qqfspugamjp42e4q28kqs8s7vcp").unwrap();
    let creator = canon_creator.as_slice();

    let checksum = hash_sha256("checksum");
    let checksum = checksum.as_slice();

    let got = {
        {{code}}

        #[allow(clippy::let_and_return)]
        canonical_address
    };

    let expected = cosmwasm_std::instantiate2_address(
        checksum,
        &canon_creator,
        salt,
    ).unwrap();

    assert_eq!(got, expected.as_slice());
}
