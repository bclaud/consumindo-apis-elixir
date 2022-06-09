defmodule ConsumindoApiWeb.PageController do
  use ConsumindoApiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
