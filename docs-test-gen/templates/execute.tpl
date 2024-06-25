use cosmwasm_std::*;
use cosmwasm_schema::cw_serde;

#[cw_serde]
struct ExecuteMsg {}

#[cfg_attr(not(feature = "library"), entry_point)]
pub fn execute(deps: DepsMut, env: Env, info: MessageInfo, msg: ExecuteMsg) -> StdResult<Response> {
    // this weird construction allows us to return a StdResult<Response> or () in the code
    // it tricks the compiler into inferring the correct generics
    trait ValidReturn {}
    impl ValidReturn for StdResult<Response<Empty>> {}
    impl ValidReturn for () {}
    fn assert_valid_return(_: &impl ValidReturn) {}

    let ret = { {{code}} };
    assert_valid_return(&ret);

    Ok(Response::default())
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
