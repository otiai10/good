defmodule GoodTest do
  use ExUnit.Case
  doctest Good

  test "then" do
    {ok?, res} = {:ok, 7}
    |> Good.then(fn n ->
      if rem(n, 2) == 0 , do: {:ok, n * 3}, else: {:error, "not even"}
    end)
    |> Good.then(fn n ->
      {:ok, n * 2}
    end)
    assert ok? == :error
    assert res == "not even"
  end

  test "otherwise" do
    {ok?, res} = {:ok, 7}
    |> Good.otherwise(fn n ->
      if rem(n, 2) == 0 , do: {:ok, n * 3}, else: {:error, "not even"}
    end)
    |> Good.then(fn n ->
      {:ok, n * 2}
    end)
    |> Good.otherwise(fn n ->
      {:error, 3}
    end)
    assert ok? == :ok
    assert res == 14
  end
end
