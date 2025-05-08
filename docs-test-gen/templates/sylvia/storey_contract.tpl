#![allow(unexpected_cfgs, dead_code, unused_variables, unused_imports, clippy::new_without_default)]

use sylvia::cw_std::{Addr, Binary, Coin, entry_point, MessageInfo, Reply, SubMsg, WasmMsg, to_json_binary, DepsMut, Empty, Env, IbcChannelOpenMsg, IbcChannelOpenResponse, Response, StdError, StdResult, SubMsgResult};
use sylvia::{contract, entry_points, interface};
use sylvia::types::{Remote, CustomMsg, CustomQuery};
use sylvia::ctx::{InstantiateCtx, QueryCtx, ExecCtx, ReplyCtx, SudoCtx, MigrateCtx};
use sylvia::cw_schema::cw_serde;
use cw_utils::MsgInstantiateContractResponse;
use cw_storey::CwStorage;
use cw_storey::containers::Item;
use storey::containers::router;
use std::marker::PhantomData;

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

        router! {
            router Root {
                0 -> remote: Item<Remote<'static, external_contract::ExternalContract>>,
            }
        }

        pub struct Contract;

        #[contract]
        impl Contract {
            pub fn new() -> Self {
                Self
            }

            #[sv::msg(instantiate)]
            fn instantiate(&self, _ctx: InstantiateCtx) -> StdResult<Response> {
                Ok(Response::new())
            }

            {{code}}
        }
    }
}
