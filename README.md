# The CosmWasm documentation platform

## What is it?

A documentation-focused website for all CosmWasm-related technologies.

No matter if you need to integrate CosmWasm with a chain, create some smart
contracts, or just have a look around to see what CosmWasm is about, here you'll
be able to learn about CosmWasm's core, wasmd, storage, testing, IBC,
CosmJS/InterchainJS, Sylvia framework, etc.

## Where is it?

The website is hosted at
[https://cosmwasm-docs.vercel.app](https://cosmwasm-docs.vercel.app/).

## How is it made?

The deployed documentation is a [Nextra](https://nextra.site) project configured
with the `nextra-theme-docs` package.

## How can I run it locally?

You can just clone this repo and run the following commands, after making sure
you use node `v20`:

```shell
npm install
npm run build
npm run start
```

You will now be able visit the locally served website at
[http://localhost:3000](http://localhost:3000)

## How can I contribute?

After cloning this repo, make sure you use node `v20` before running these
commands:

```shell
npm install
npm run dev
```

The website will be available at [http://localhost:3000](http://localhost:3000)
and the changes you make to the project will be reflected there instantaneously.

There's a hidden "How to doc" section that'll teach you how to write new
entries. You can make this section visible by visiting
[http://localhost:3000/how-to-doc](http://localhost:3000/how-to-doc) or with the
<kbd>CTRL</kbd> + <kbd>.</kbd> (control plus period) keyboard shortcut.

After committing your changes to a new branch, push it to this repo and open a
PR. This will automatically generate a Vercel preview link for the reviewers to
check.
