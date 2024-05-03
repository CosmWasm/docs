use cosmwasm_std::*;
use cosmwasm_schema::cw_serde;

#[cw_serde]
struct InstantiateMsg {}

#[cw_serde]
struct QueryMsg {}

#[cw_serde]
struct ExecuteMsg {}

#[test]
fn doctest() {
  #[entry_point]
pub fn instantiate(
    deps: DepsMut,
    env: Env,
    info: MessageInfo,
    msg: InstantiateMsg,
) -> Result<Response, StdError> {
    // Do some logic here
    Ok(Response::default())
}

}
