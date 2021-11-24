defmodule LoginWeb.AdminUserController do
  use LoginWeb, :controller

  alias Login.AdminUsers
  alias Login.AdminUsers.AdminUser
  alias Login.Users
  alias LoginWeb.AdminAuth

  def index(conn, _params) do
    admin_users = AdminUsers.list_admin_users()
    render(conn, "index.html", admin_users: admin_users)
  end

  def new(conn, _params) do
    changeset = AdminUsers.change_admin_user(%AdminUser{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"admin_user" => admin_user_params}) do
    case AdminUsers.create_admin_user(admin_user_params) do
      {:ok, admin_user} ->
        user_token = AdminUsers.deliver_user_confirmation_instructions(admin_user)

        conn
        |> put_flash(:info, "Admin user created successfully.")
        |> AdminAuth.log_in_admin_user(admin_user)
        |> redirect(to: Routes.admin_user_path(conn, :show, admin_user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def logged_in_page(conn, _params) do
    render(conn, "logged_in.html")
  end

  def list_user_pending(conn, _params) do
    users = Users.get_user_by_role_pending("pending")

    render(conn, "list_user.html", users: users)
  end

  def aprove_user(conn, %{"id" => id}) do
    user = Users.get_user!(id)

    AdminUsers.update_role(user, %{"role" => "user"})

    conn
    |> put_flash(:info, "Role aproved successfully for User Request..!!")
    |> redirect(to: "/list_pending_users")
  end

  def reject_user(conn, %{"id" => id}) do
    user = Users.get_user!(id)

    AdminUsers.delete_user(user)

    conn
    |> put_flash(:info, "Successfully removed this User..!!")
    |> redirect(to: "/list_pending_users")
  end

  def show(conn, %{"id" => id}) do
    admin_user = AdminUsers.get_admin_user!(id)
    render(conn, "show.html", admin_user: admin_user)
  end

  def edit(conn, %{"id" => id}) do
    admin_user = AdminUsers.get_admin_user!(id)
    changeset = AdminUsers.change_admin_user(admin_user)
    render(conn, "edit.html", admin_user: admin_user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "admin_user" => admin_user_params}) do
    admin_user = AdminUsers.get_admin_user!(id)

    case AdminUsers.update_admin_user(admin_user, admin_user_params) do
      {:ok, admin_user} ->
        conn
        |> put_flash(:info, "Admin user updated successfully.")
        |> redirect(to: Routes.admin_user_path(conn, :show, admin_user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", admin_user: admin_user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    admin_user = AdminUsers.get_admin_user!(id)
    {:ok, _admin_user} = AdminUsers.delete_admin_user(admin_user)

    conn
    |> put_flash(:info, "Admin user deleted successfully.")
    |> redirect(to: Routes.admin_user_path(conn, :index))
  end

  # def list_users() do
  #   Users.get_user_by_role_pending()
  # end
end
