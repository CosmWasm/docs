#![allow(unexpected_cfgs, dead_code, unused_variables, unused_imports, clippy::new_without_default)]

use sylvia::cw_std::{Addr, Binary, Coin, entry_point, Reply, SubMsg, WasmMsg, to_json_binary, DepsMut, Empty, Env, IbcChannelOpenMsg, IbcChannelOpenResponse, Response, StdError, StdResult, SubMsgResult};
use sylvia::{contract, entry_points, interface};
use sylvia::types::Remote;
use sylvia::ctx::{InstantiateCtx, QueryCtx, ExecCtx, ReplyCtx, SudoCtx, MigrateCtx};
use sylvia::cw_schema::cw_serde;
use cw_utils::MsgInstantiateContractResponse;
use cw_storey::CwStorage;
use external_contract::ExternalContract;

pub mod external_contract {
    use sylvia::contract;
    use sylvia::ctx::{InstantiateCtx, ExecCtx};
    use sylvia::cw_std::{Response, StdResult};

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

        #[sv::msg(exec)]
        fn external_exec(&self, _ctx: ExecCtx) -> StdResult<Response> {
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

pub mod external_interface {
    use sylvia::interface;
    use sylvia::cw_std::{CustomMsg, CustomQuery, StdError};

    #[interface]
    pub trait SomeInterface {
        type Error: From<StdError>;
        type ExecC: CustomMsg;
        type QueryC: CustomQuery;
        type CounterT: CustomMsg;
    }
}


#[test]
fn doctest() {
    pub mod contract_code {
        use super::*;

        {{code}}
    }
}
