# Basecamp

Phoenix 1.8 + LiveVue starter for building fullstack apps with server-rendered LiveView and Vue.js client components.

## Tech Stack

- **Phoenix 1.8** / Elixir — web framework, LiveView real-time UI
- **LiveVue** — Vue 3 components inside LiveView with SSR
- **Vite** — asset bundling and HMR
- **Tailwind CSS v4** — styling
- **PostgreSQL** — database via Ecto
- **Bandit** — HTTP server

## Requirements

- Erlang/OTP 27+
- Elixir 1.18+
- Node.js 25+
- PostgreSQL 17+

## Getting Started

**First, rename the project to your app name:**

```sh
./scripts/rename.sh my_app
```

This replaces all occurrences of `basecamp` / `Basecamp` — module names, config atoms, database names, directories — and cleans build artifacts. Then:

```sh
mix setup
make run-dev
```

The app runs at [http://localhost:4002](http://localhost:4002).

Vite dev server runs on port 5175 for HMR and asset serving.

## Development

```sh
make run-dev              # start Phoenix + Vite dev servers
mix test                  # run tests
mix precommit             # compile (warnings-as-errors), format, test
mix phx.server            # start Phoenix server directly
iex -S mix phx.server     # start with interactive shell
```

## Project Structure

```
lib/
  basecamp/               # business logic, schemas, contexts
  basecamp_web/
    components/            # Phoenix function components, layouts
    controllers/           # controllers and error handlers
    live/                  # LiveView modules
    router.ex              # routes
assets/
  vue/                     # Vue 3 components (Counter.vue, etc.)
  js/                      # JS entry points
  css/                     # stylesheets (Tailwind)
config/
  config.exs               # shared config
  dev.exs                  # dev config (db, endpoints, Vite)
  test.exs                 # test config
  runtime.exs              # runtime/production config
priv/
  repo/migrations/         # Ecto migrations
  static/                  # compiled static assets (prod)
```

## Using Vue Components

Vue components live in `assets/vue/` and are rendered inside LiveView templates with the `<.vue>` component:

```heex
<.vue v-component="Counter" v-socket={@socket} count={@count} />
```

All non-`v-` prefixed attributes are passed as props to the Vue component.

## Database

Default dev connection: `postgres:postgres@localhost/basecamp_dev` (see `config/dev.exs`).

```sh
mix ecto.create            # create database
mix ecto.migrate           # run migrations
mix ecto.reset             # drop, create, migrate, seed
mix phx.gen.schema ...     # generate Ecto schema
```

## Dev Routes

Available in development only:

- [/dev/dashboard](http://localhost:4002/dev/dashboard) — Phoenix LiveDashboard
- [/dev/mailbox](http://localhost:4002/dev/mailbox) — Swoosh email preview
