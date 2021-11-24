defmodule Login.AdminUsersTest do
  use Login.DataCase

  alias Login.AdminUsers

  describe "admin_users" do
    alias Login.AdminUsers.AdminUser

    @valid_attrs %{email: "some email", password: "some password", role: "some role"}
    @update_attrs %{
      email: "some updated email",
      password: "some updated password",
      role: "some updated role"
    }
    @invalid_attrs %{email: nil, password: nil, role: nil}

    def admin_user_fixture(attrs \\ %{}) do
      {:ok, admin_user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> AdminUsers.create_admin_user()

      admin_user
    end

    test "list_admin_users/0 returns all admin_users" do
      admin_user = admin_user_fixture()
      assert AdminUsers.list_admin_users() == [admin_user]
    end

    test "get_admin_user!/1 returns the admin_user with given id" do
      admin_user = admin_user_fixture()
      assert AdminUsers.get_admin_user!(admin_user.id) == admin_user
    end

    test "create_admin_user/1 with valid data creates a admin_user" do
      assert {:ok, %AdminUser{} = admin_user} = AdminUsers.create_admin_user(@valid_attrs)
      assert admin_user.email == "some email"
      assert admin_user.password == "some password"
      assert admin_user.role == "some role"
    end

    test "create_admin_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AdminUsers.create_admin_user(@invalid_attrs)
    end

    test "update_admin_user/2 with valid data updates the admin_user" do
      admin_user = admin_user_fixture()

      assert {:ok, %AdminUser{} = admin_user} =
               AdminUsers.update_admin_user(admin_user, @update_attrs)

      assert admin_user.email == "some updated email"
      assert admin_user.password == "some updated password"
      assert admin_user.role == "some updated role"
    end

    test "update_admin_user/2 with invalid data returns error changeset" do
      admin_user = admin_user_fixture()

      assert {:error, %Ecto.Changeset{}} =
               AdminUsers.update_admin_user(admin_user, @invalid_attrs)

      assert admin_user == AdminUsers.get_admin_user!(admin_user.id)
    end

    test "delete_admin_user/1 deletes the admin_user" do
      admin_user = admin_user_fixture()
      assert {:ok, %AdminUser{}} = AdminUsers.delete_admin_user(admin_user)
      assert_raise Ecto.NoResultsError, fn -> AdminUsers.get_admin_user!(admin_user.id) end
    end

    test "change_admin_user/1 returns a admin_user changeset" do
      admin_user = admin_user_fixture()
      assert %Ecto.Changeset{} = AdminUsers.change_admin_user(admin_user)
    end
  end
end
