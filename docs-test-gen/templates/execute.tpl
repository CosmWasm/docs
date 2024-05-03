use cosmwasm_std::*;
use cosmwasm_schema::cw_serde;

#[cw_serde]
struct ExecuteMsg {}

#[entry_point]
pub fn execute(deps: DepsMut, env: Env, info: MessageInfo, msg: ExecuteMsg) -> StdResult<Response> {
    {{code}}
}

#[test]
fn doctest() {
    use cosmwasm_std::testing::*;

    let mut deps = mock_dependencies();
    let env = mock_env();
    let info = mock_info("sender", &[]);
    let msg = ExecuteMsg {};

    let res = execute(deps.as_mut(), env, info, msg).unwrap();
}
