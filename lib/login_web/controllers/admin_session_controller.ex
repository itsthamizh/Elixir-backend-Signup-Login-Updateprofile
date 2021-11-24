defmodule LoginWeb.AdminSessionController do
  use LoginWeb, :controller

  alias Login.AdminUsers

  # alias Login.Users

  alias LoginWeb.AdminAuth

  def new(conn, _params) do
    render(conn, "session.html", error_message: nil)
  end

  def create(conn, params) do
    user_params = params["admin_user"]

    %{"email" => email, "password" => password} = user_params

    if user = AdminUsers.get_user_by_email_and_password(email, password) do
      AdminAuth.log_in_admin_user(conn, user, user_params)
    else
      render(conn, "new.html", error_message: "Invalid email or password")
    end
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "Logged out successfully.")
    |> AdminAuth.log_out_admin_user()
  end
end
