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

mod ibc {
    use super::*;

    use cw_storage_plus::Item;
    use cosmos_sdk_proto::ibc::core::channel::v1::MsgChannelOpenInit;

    pub fn new_msg_channel_open_init(
        deps: Deps,
        env: &Env,
        connection_id: String,
        counterparty_port_id: String,
    ) -> StdResult<MsgChannelOpenInit> {
        todo!() // stub
    }

    pub const ALLOW_CHANNEL_OPENING: Item<bool> = Item::new("allow_opening");
}

#[test]
fn doctest() {
  {{code}}
}
