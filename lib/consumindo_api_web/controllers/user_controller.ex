defmodule ConsumindoApiWeb.UserController do
  use ConsumindoApiWeb, :controller

  alias ConsumindoApiWeb.Auth.Guardian, as: Token

  def create(conn, %{"password" => _password} = params) do
    with {:ok, user_id} <- ConsumindoApi.Users.Create.call(params) do
      conn
      |> put_status(201)
      |> render("create.json", user_id: user_id)
    end
  end

  def login(conn, %{"password" => password, "id" => id} = _params) do
    with {:ok, token} <- Token.authenticate(id, password) do
      conn
      |> put_status(:ok)
      |> render("token.json", token: token)
    end
  end
end
