defmodule Login.Repo.Migrations.CreateAdminUsers do
  use Ecto.Migration

  def change do
    create table(:admin_users) do
      add :email, :string
      add :password, :string
      add :role, :string

      timestamps()
    end

    create unique_index(:admin_users, [:email])

    create table(:admin_users_tokens) do
      add :admin_user_id, references(:admin_users, on_delete: :delete_all), null: false
      add :token, :binary, null: false
      add :context, :string, null: false
      add :sent_to, :string
      timestamps(updated_at: false)
    end

    create index(:admin_users_tokens, [:admin_user_id])
    create unique_index(:admin_users_tokens, [:context, :token])
  end
end
