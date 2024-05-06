use cosmwasm_std::*;
use cosmwasm_schema::cw_serde;

#[cw_serde]
struct InstantiateMsg {}

#[cw_serde]
struct QueryMsg {}

#[cw_serde]
struct ExecuteMsg {}

#[cw_serde]
struct MigrateMsg {}

#[test]
fn doctest() {
  {{code}}
}
