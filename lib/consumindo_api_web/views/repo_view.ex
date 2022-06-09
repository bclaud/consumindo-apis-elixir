defmodule ConsumindoApiWeb.RepoView do
  use ConsumindoApiWeb, :view

  @attrs_to_show [
    "id",
    "name",
    "description",
    "html_url",
    "stargazers_count"
  ]

  def render("show.json", %{repos: repos}) do
    for repo <- repos, do: Map.take(repo, @attrs_to_show)
  end
end
