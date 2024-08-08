#[allow(unused_imports)]
mod imports {
    pub use cosmwasm_schema::cw_serde;
    pub use cosmwasm_std::*;
}

#[allow(unused_imports)]
use imports::*;

#[allow(dead_code, unused_variables)]
mod users {
    use super::*;

    use cw_storage_plus::{index_list, IndexedMap, MultiIndex, UniqueIndex};

    pub type Handle = String;

    #[cw_serde]
    pub struct User {
        pub handle: String,
        pub country: String,
    }

    pub struct ExampleUsers {
        pub alice: User,
        pub bob: User,
    }

    pub fn example_users() -> ExampleUsers {
        ExampleUsers {
            alice: User {
                handle: "alice".to_string(),
                country: "Wonderland".to_string(),
            },
            bob: User {
                handle: "bob".to_string(),
                country: "USA".to_string(),
            },
        }
    }

    #[index_list(User)]
    pub struct UserIndexes<'a> {
        pub handle_ix: UniqueIndex<'a, Handle, User, Addr>,
        pub country_ix: MultiIndex<'a, String, User, Addr>,
    }

    pub fn user_indexes() -> UserIndexes<'static> {
        user_indexes_custom("u", "uh", "uc")
    }

    pub fn user_indexes_custom(
        ns: &'static str,
        handle_prefix: &'static str,
        country_prefix: &'static str,
    ) -> UserIndexes<'static> {
        UserIndexes {
            handle_ix: UniqueIndex::new(|user| user.handle.clone(), handle_prefix),
            country_ix: MultiIndex::new(|_pk, user| user.country.clone(), ns, country_prefix),
        }
    }
}

fn advance_height(env: &mut Env, blocks: u64) {
    env.block.height += blocks;
}

#[test]
fn doctest() {
    #[allow(unused_variables, unused_mut)]
    let mut storage = cosmwasm_std::testing::MockStorage::new();
    let mut env = cosmwasm_std::testing::mock_env();

    let users = cw_storage_plus::IndexedMap::<Addr, _, _>::new(
        "uu",
        users::user_indexes_custom("uu", "uuh", "uuc"),
    );

    let users_data = [
        (
            Addr::unchecked("aaa"),
            users::User {
                handle: "alice".to_string(),
                country: "Wonderland".to_string(),
            },
        ),
        (
            Addr::unchecked("bbb"),
            users::User {
                handle: "bob".to_string(),
                country: "USA".to_string(),
            },
        ),
        (
            Addr::unchecked("ccc"),
            users::User {
                handle: "carol".to_string(),
                country: "UK".to_string(),
            },
        ),
        (
            Addr::unchecked("ddd"),
            users::User {
                handle: "dave".to_string(),
                country: "USA".to_string(),
            },
        ),
    ];

    for (addr, user) in users_data {
        users.save(&mut storage, addr, &user).unwrap();
    }

    #[rustfmt::skip]
    {{code}}
}
