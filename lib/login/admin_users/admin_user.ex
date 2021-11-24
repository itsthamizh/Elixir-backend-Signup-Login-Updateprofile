defmodule Login.AdminUsers.AdminUser do
  use Ecto.Schema
  import Ecto.Changeset

  schema "admin_users" do
    field :email, :string
    field :password, :string
    field :role, :string

    timestamps()
  end

  @doc false
  def changeset(admin_user, attrs) do
    admin_user
    |> cast(attrs, [:email, :password, :role])
    |> validate_required([:email, :password, :role])
  end
end
