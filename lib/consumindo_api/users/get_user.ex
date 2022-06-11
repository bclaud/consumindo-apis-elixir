defmodule ConsumindoApi.Users.Get do
  alias ConsumindoApi.{User, Repo}

  def call(id) do
    Repo.get(User, id)
  end
end
