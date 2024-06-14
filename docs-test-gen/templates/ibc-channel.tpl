use cosmwasm_std::*;
use cosmwasm_schema::cw_serde;

#[cw_serde]
struct InstantiateMsg {}

#[cw_serde]
struct QueryMsg {}

#[cw_serde]
pub struct ExecuteMsg {
    counterparty_port_id: String,
    connection_id: String,
}

pub enum ContractError {
    ChannelOpenInitNotAllowed {},
}

impl From<StdError> for ContractError {
    fn from(err: StdError) -> Self {
        ContractError::ChannelOpenInitNotAllowed {}
    }
}

#[test]
fn doctest() {
  {{code}}
}
