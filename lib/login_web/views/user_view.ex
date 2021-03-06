defmodule LoginWeb.UserView do
  use LoginWeb, :view
  alias LoginWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      user_name: user.user_name,
      password: user.password,
      email: user.email,
      phone_no: user.phone_no
    }
  end
end
