#![allow(
    unexpected_cfgs,
    dead_code,
    unused_variables,
    unused_imports,
    clippy::new_without_default
)]
use cosmwasm_schema::cw_serde;
use cosmwasm_std::*;
use storey::containers::{IterableStorable, NonTerminal, Storable};
use storey::storage::{IntoStorage, StorageBranch};

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
    pub struct MyMap<V> {
        prefix: u8,
        phantom: std::marker::PhantomData<V>,
    }

    impl<V> MyMap<V>
    where
        V: Storable,
    {
        pub const fn new(prefix: u8) -> Self {
            Self {
                prefix,
                phantom: std::marker::PhantomData,
            }
        }

        pub fn access<F, S>(&self, storage: F) -> MyMapAccess<V, StorageBranch<S>>
        where
            (F,): IntoStorage<S>,
        {
            let storage = (storage,).into_storage();
            Self::access_impl(StorageBranch::new(storage, vec![self.prefix]))
        }
    }

    pub struct MyMapAccess<V, S> {
        storage: S,
        phantom: std::marker::PhantomData<V>,
    }

    impl<V> Storable for MyMap<V>
    where
        V: Storable,
    {
        type Kind = NonTerminal;
        type Accessor<S> = MyMapAccess<V, S>;

        fn access_impl<S>(storage: S) -> MyMapAccess<V, S> {
            MyMapAccess {
                storage,
                phantom: std::marker::PhantomData,
            }
        }
    }

    impl<V, S> MyMapAccess<V, S>
    where
        V: Storable,
    {
        pub fn entry(&self, key: u32) -> V::Accessor<StorageBranch<&S>> {
            let key = key.to_be_bytes().to_vec();

            V::access_impl(StorageBranch::new(&self.storage, key))
        }

        pub fn entry_mut(&mut self, key: u32) -> V::Accessor<StorageBranch<&mut S>> {
            let key = key.to_be_bytes().to_vec();

            V::access_impl(StorageBranch::new(&mut self.storage, key))
        }
    }

    #[allow(unused_variables, unused_mut)]
    let mut storage = cosmwasm_std::testing::MockStorage::new();
    #[allow(unused_mut)]
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
