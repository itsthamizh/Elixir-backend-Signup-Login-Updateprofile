defmodule Login.AdminUsers do
  @moduledoc """
  The AdminUsers context.
  """

  import Ecto.Query, warn: false
  alias Login.Repo

  alias Login.AdminUsers.AdminUser
  alias Login.AdminUsers.AdminToken
  alias Login.Users
  alias Login.Users.User

  @doc """
  Returns the list of admin_users.

  ## Examples

      iex> list_admin_users()
      [%AdminUser{}, ...]

  """
  def list_admin_users do
    Repo.all(AdminUser)
  end

  @doc """
  Gets a single admin_user.

  Raises `Ecto.NoResultsError` if the Admin user does not exist.

  ## Examples

      iex> get_admin_user!(123)
      %AdminUser{}

      iex> get_admin_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_admin_user!(id), do: Repo.get!(AdminUser, id)

  @doc """
  Creates a admin_user.

  ## Examples

      iex> create_admin_user(%{field: value})
      {:ok, %AdminUser{}}

      iex> create_admin_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_admin_user(attrs \\ %{}) do
    %AdminUser{}
    |> AdminUser.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a admin_user.

  ## Examples

      iex> update_admin_user(admin_user, %{field: new_value})
      {:ok, %AdminUser{}}

      iex> update_admin_user(admin_user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_admin_user(%AdminUser{} = admin_user, attrs) do
    admin_user
    |> AdminUser.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a admin_user.

  ## Examples

      iex> delete_admin_user(admin_user)
      {:ok, %AdminUser{}}

      iex> delete_admin_user(admin_user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_admin_user(%AdminUser{} = admin_user) do
    Repo.delete(admin_user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking admin_user changes.

  ## Examples

      iex> change_admin_user(admin_user)
      %Ecto.Changeset{data: %AdminUser{}}

  """
  def change_admin_user(%AdminUser{} = admin_user, attrs \\ %{}) do
    AdminUser.changeset(admin_user, attrs)
  end

  def get_user_by_email_and_password(email, password)
      when is_binary(email) and is_binary(password) do
    user = Repo.get_by(AdminUser, email: email)

    # if User.valid_password?(user, password), do: user
  end

  def generate_user_session_token(user) do
    {token, user_token} = AdminToken.build_session_token(user)

    Repo.insert!(user_token)

    token
  end

  def deliver_user_confirmation_instructions(%AdminUser{} = admin_user) do
    {encoded_token, user_token} = AdminToken.build_email_token(admin_user, "confirm")

    Repo.insert!(user_token)
  end

  def delete_session_token(token) do
    Repo.delete_all(AdminToken.token_and_context_query(token, "session"))

    :ok
  end

  def update_role(%User{} = user, attrs) do
    user
    |> User.update_registration_changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end
end
