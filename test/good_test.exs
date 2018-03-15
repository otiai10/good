defmodule GoodTest do
  use ExUnit.Case
  doctest Good
  import Good

  test "then" do
    {ok?, res} = {:ok, 7}
    |> then(fn n ->
      if rem(n, 2) == 0 , do: {:ok, n * 3}, else: {:error, "not even"}
    end)
    |> then(fn n ->
      {:ok, n * 2}
    end)
    assert ok? == :error
    assert res == "not even"
  end

  test "otherwise" do
    {ok?, res} = {:ok, 7}
    |> otherwise(fn n ->
      if rem(n, 2) == 0 , do: {:ok, n * 3}, else: {:error, "not even"}
    end)
    |> then(fn n ->
      {:ok, n * 2}
    end)
    |> otherwise(fn _ ->
      {:error, 3}
    end)
    assert ok? == :ok
    assert res == 14
  end
end
