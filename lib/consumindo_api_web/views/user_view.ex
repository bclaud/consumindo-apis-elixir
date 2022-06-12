defmodule ConsumindoApiWeb.UserView do
  use ConsumindoApiWeb, :view

  def render("create.json", %{user_id: user_id}) do
    %{user_id: user_id}
  end

  def render("token.json", %{token: token}) do
    %{token: token}
  end
end
