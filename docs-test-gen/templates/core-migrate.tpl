use cosmwasm_std::*;
use cosmwasm_schema::cw_serde;

#[derive(Default)]
struct OldData {}

#[cw_serde]
struct MigrateMsg {}

fn from_slice<T: Default>(_data: &[u8]) -> StdResult<T> {
    Ok(T::default())
}

fn to_vec<T>(_data: &T) -> StdResult<Vec<u8>> {
    Ok(Vec::new())
}

fn transform(_old_data: OldData) -> () {
    ()
}

#[test]
fn doctest() {
  {{code}}
}
