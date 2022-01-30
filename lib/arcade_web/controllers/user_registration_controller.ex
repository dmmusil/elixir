defmodule ArcadeWeb.UserRegistrationController do
  use ArcadeWeb, :controller

  alias Arcade.Accounts
  alias Arcade.Accounts.User
  alias ArcadeWeb.UserAuth

  def new(conn, _params) do
    changeset = Accounts.change_user_registration(%User{})
    render(conn, "new.html", changeset: changeset, disabled: true)
  end

  def create(conn, %{"user" => user_params}) do
    if Mix.env() == :prod do
      changeset = Accounts.change_user_registration(%User{})
      render(conn, "new.html", disabled: true, changeset: changeset)
    else
      case Accounts.register_user(user_params) do
        {:ok, user} ->
          {:ok, _} =
            Accounts.deliver_user_confirmation_instructions(
              user,
              &Routes.user_confirmation_url(conn, :edit, &1)
            )

          conn
          |> put_flash(:info, "User created successfully.")
          |> UserAuth.log_in_user(user)

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset, disabled: false)
      end
    end
  end
end
