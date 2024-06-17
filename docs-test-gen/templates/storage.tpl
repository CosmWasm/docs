#[allow(unused_imports)]
mod imports {
    pub use cosmwasm_std::*;
    pub use cosmwasm_schema::cw_serde;
}

#[allow(unused_imports)]
use imports::*;

#[test]
fn doctest() {
  #[allow(unused_mut)]
  let mut storage = cosmwasm_std::testing::MockStorage::new();
  {{code}}
}
