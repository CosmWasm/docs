#![allow(unexpected_cfgs, dead_code, unused_variables, unused_imports)]

use sylvia::cw_std::{Addr, Binary, Coin, entry_point, Reply, SubMsg, WasmMsg, to_json_binary, DepsMut, Empty, Env, IbcChannelOpenMsg, IbcChannelOpenResponse, Response, StdError, StdResult, SubMsgResult};
use sylvia::{contract, entry_points, interface};
use sylvia::types::Remote;
use sylvia::ctx::{InstantiateCtx, QueryCtx, ExecCtx, ReplyCtx, SudoCtx, MigrateCtx};
use sylvia::cw_schema::cw_serde;
use cw_utils::MsgInstantiateContractResponse;
use cw_storey::CwStorage;
use cw_storey::containers::Item;

pub mod external_contract {
    use super::*;

    pub struct ExternalContract;

    #[contract]
    impl ExternalContract {
        pub fn new() -> Self {
            Self
        }

        #[sv::msg(instantiate)]
        fn instantiate(&self, _ctx: InstantiateCtx) -> StdResult<Response> {
            Ok(Response::new())
        }
    }
}

#[cw_serde]
pub enum ExternalExecMsg {
    Increment {}
}

#[cw_serde]
pub enum ExternalQueryMsg {
    Count {}
}

#[cw_serde]
pub struct ExternalResponse {}


#[test]
fn doctest() {
    pub mod main_contract {
        use super::*;

        pub struct Contract {
            remote: Item<Remote<'static, external_contract::ExternalContract>>
        }

        #[contract]
        impl Contract {
            pub fn new() -> Self {
                Self {
                    remote: Item::new(0)
                }
            }

            #[sv::msg(instantiate)]
            fn instantiate(&self, _ctx: InstantiateCtx) -> StdResult<Response> {
                Ok(Response::new())
            }

            {{code}}
        }
    }
}
