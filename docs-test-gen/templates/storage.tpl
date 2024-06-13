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

    use cw_storage_plus::{index_list, IndexedMap, UniqueIndex};

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
    }

    pub fn user_indexes(prefix: &'static str) -> UserIndexes<'static> {
        UserIndexes {
            handle_ix: UniqueIndex::new(|user| user.handle.clone(), prefix),
        }
    }
}

#[test]
fn doctest() {
    #[allow(unused_variables, unused_mut)]
    let mut storage = cosmwasm_std::testing::MockStorage::new();

    let users = cw_storage_plus::IndexedMap::<Addr, _, _>::new("uu", users::user_indexes("uuh"));

    let users_data = [
        (
            Addr::unchecked("alice"),
            users::User {
                handle: "alice".to_string(),
                country: "Wonderland".to_string(),
            },
        ),
        (
            Addr::unchecked("bob"),
            users::User {
                handle: "bob".to_string(),
                country: "USA".to_string(),
            },
        ),
        (
            Addr::unchecked("carol"),
            users::User {
                handle: "carol".to_string(),
                country: "UK".to_string(),
            },
        ),
    ];

    for (addr, user) in users_data {
        users.save(&mut storage, addr, &user).unwrap();
    }

    #[rustfmt::skip]
    {{code}}
}
