defmodule Good do

  @doc """
  """
  def then({:error, reason}, _), do: {:error, reason}
  def then({:ok, arg}, next), do: next.(arg)

  @doc """
  """
  def otherwise({:ok, arg}, _), do: {:ok, arg}
  def otherwise({:error, reason}, next), do: next.(reason)

end
