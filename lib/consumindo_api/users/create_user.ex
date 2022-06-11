defmodule ConsumindoApi.Users.Create do
  alias ConsumindoApi.{User, Repo}

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %{id: id}}) do
    {:ok, id}
  end

  defp handle_insert({:error, reason}), do: {:error, reason}
end
