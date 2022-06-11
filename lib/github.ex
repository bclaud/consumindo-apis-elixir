defmodule ConsumindoApi.Github do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://api.github.com"
  plug Tesla.Middleware.JSON

  @type url :: String.t()

  @base_url "https://api.github.com"

  @spec get_user_repos(String) :: {:ok, [map]} | {:error, String}
  def get_user_repos(username) do
    get_user_repos(@base_url, username)
  end

  @spec get_user_repos(url, String) :: {:ok, [map]} | {:error, String}
  def get_user_repos(url, username) do
    case get(url <> "/users/" <> username <> "/repos") do
      {:error, reason} -> {:error, reason}
      {:ok, %{status: 200, body: body}} -> {:ok, body}
      {:ok, %{status: 404}} -> {:error, "User not found"}
      {:ok, %{status: 500}} -> {:error, "Unexpected response from API"}
    end
  end
end
