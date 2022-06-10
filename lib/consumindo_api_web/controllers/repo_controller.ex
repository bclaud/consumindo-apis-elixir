defmodule ConsumindoApiWeb.RepoController do
  use ConsumindoApiWeb, :controller
  alias ConsumindoApi.Github

  def show(conn, %{"username" => username}) do
    case Github.get_user_repos(username) do
      {:ok, repos_info} ->
        conn
        |> put_status(:ok)
        |> render("show.json", repos: repos_info)
    end
  end
end
