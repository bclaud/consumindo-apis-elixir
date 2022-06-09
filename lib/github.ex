defmodule ConsumindoApi.Github do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://api.github.com"
  plug Tesla.Middleware.JSON

  @spec get_user_repo(String) :: {:ok, map} | {:error, String}
  def get_user_repo(username) do
    case get("/users/" <> username <> "/repos") do
      {:error, reason} -> {:error, reason}
      {:ok, %Tesla.Env{status: 200, body: body}} -> {:ok, body}
    end
  end
end
