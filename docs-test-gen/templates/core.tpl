use cosmwasm_std::*;
use cosmwasm_schema::cw_serde;

#[cw_serde]
enum OtherContractMsg {
  DoSomething {}
}

#[cw_serde]
struct InstantiateMsg {}

#[cw_serde]
struct QueryMsg {}

#[cw_serde]
struct ExecuteMsg {}

#[cw_serde]
struct MigrateMsg {}

#[cw_serde]
struct SudoMsg {}

fn from_slice<T: Default>(_data: &[u8]) -> StdResult<T> {
    Ok(T::default())
}

fn to_vec<T>(_data: &T) -> StdResult<Vec<u8>> {
    Ok(Vec::new())
}

fn transform(_old_data: OldData) -> () {
    ()
}

#[derive(Default)]
struct OldData {}

#[test]
fn doctest() {
  {{code}}
}
