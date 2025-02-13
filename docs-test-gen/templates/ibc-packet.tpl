#![allow(unexpected_cfgs, dead_code, unused_variables, unused_imports)]

use cosmwasm_std::*;
use cosmwasm_schema::cw_serde;

#[cw_serde]
struct ChannelInfo {
    channel_id: String,
    /// whether the channel is completely set up
    finalized: bool,
}

#[cfg_attr(not(feature = "library"), entry_point)]
pub fn execute(deps: DepsMut, env: Env, info: MessageInfo, msg: Empty) -> StdResult<Response> {
    {{code}}
}

#[test]
fn doctest() {
    use cosmwasm_std::testing::*;

    let mut deps = mock_dependencies();
    let env = mock_env();
    let info = message_info(&Addr::unchecked("sender"), &[]);
    let msg = Empty {};

    // prepare channel info
    let channel_info = ChannelInfo {
        channel_id: "channel-0".to_string(),
        finalized: false,
    };
    // save channel to storage for both StoragePlus and Storey
    {
        use cw_storage_plus::Item;
        const CHANNEL: Item<ChannelInfo> = Item::new("channel");
        CHANNEL.save(&mut deps.storage, &channel_info).unwrap();
    }
    {
        use cw_storey::{containers::Item, CwStorage};
        const CHANNEL: Item<ChannelInfo> = Item::new(0);
        CHANNEL.access(&mut deps.storage).set(&channel_info).unwrap();
    }


    let res = execute(deps.as_mut(), env, info, msg).unwrap();
}
