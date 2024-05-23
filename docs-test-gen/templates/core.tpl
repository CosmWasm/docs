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

fn transform(_old_data: OldData) -> () {
    ()
}

#[cw_serde]
#[derive(Default)]
struct OldData {}

#[test]
fn doctest() {
  {{code}}
}
