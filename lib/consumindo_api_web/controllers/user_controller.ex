defmodule ConsumindoApiWeb.UserController do
  use ConsumindoApiWeb, :controller

  def create(conn, %{"password" => _password} = params) do
    with {:ok, user_id} <- ConsumindoApi.Users.Create.call(params) do
      conn
      |> put_status(201)
      |> render("create.json", user_id: user_id)
    end
  end
end
