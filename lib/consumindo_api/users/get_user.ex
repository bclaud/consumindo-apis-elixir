defmodule ConsumindoApi.Users.Get do
  alias ConsumindoApi.{User, Repo}

  def call(id) do
    case Repo.get(User, id) do
      nil -> {:error, "user not fould"}
      user -> {:ok, user}
    end
  end
end
