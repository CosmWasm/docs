#[allow(unused_imports)]
mod imports {
    pub use cosmwasm_std::*;
    pub use cosmwasm_schema::cw_serde;
}

use imports::*;

#[test]
fn doctest() {
  let mut storage = cosmwasm_std::testing::MockStorage::new();
  {{code}}
}
