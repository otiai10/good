# Good

Module `Good` enable you `early-retrun` like error handling, by falling through.

```elixir
User.changeset(%User{}, params)
|> Repo.insert
|> Good.then(fn user ->
  # if the rsult is {:ok, any}, this fn get invoked
  {:ok, "Hello, #{user.name}!"}
  # but when it's {:error, any}, this fn is fallen through
end)
|> Good.otherwise(fn changeset ->
  # otherwise, `otherwise` catches {:error, any}
  {:error, changeset.errors |> Enum.into(%{})}
  # or off course, you can retry Repo.insert here
end)
|> case  do
    {:ok, message} -> json conn, message
    {:error, reason} -> put_status(conn, 500) |> json reason
end
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add good to your list of dependencies in `mix.exs`:

        def deps do
          [{:good, "~> 0.0.1"}]
        end

  2. Ensure good is started before your application:

        def application do
          [applications: [:good]]
        end
