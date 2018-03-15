# Good

[![Build Status](https://travis-ci.org/otiai10/good.svg?branch=master)](https://travis-ci.org/otiai10/good)

Module `Good` enable you **Early Return** like error handling, by falling through.

```elixir
import Good

User.changeset(%User{}, params)
|> Repo.insert
|> then(fn user ->
  {:ok, "Hello, #{user.name}!"}
end)
|> otherwise(fn changeset ->
  {:error, changeset.errors |> Enum.into(%{})}
end)
|> case do
  # Everything comes here anyway
  {:ok, message} -> json conn, message
  {:error, reason} -> put_status(conn, 500) |> json reason
end
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add good to your list of dependencies in `mix.exs`:
```elixir
      def deps do
        [{:good, "~> 0.0.1"}]
      end
```
  2. Ensure good is started before your application:
```elixir
      def application do
        [applications: [:good]]
      end
```
