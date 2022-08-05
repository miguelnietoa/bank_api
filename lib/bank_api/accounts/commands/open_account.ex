defmodule BankAPI.Accounts.Commands.OpenAccount do
  use Ecto.Schema
  import Ecto.Changeset

  alias BankAPI.Accounts

  @enforce_keys [:account_uuid]

  embedded_schema do
    field :account_uuid
    field :initial_balance, :integer
  end

  def validate(command) do
    command
    |> change()
    |> validate_required([:account_uuid, :initial_balance])
    |> validate_format(:account_uuid, Accounts.uuid_regex())
    |> validate_number(:initial_balance, greater_than: 0)
    |> case do
      %{valid?: true} -> :ok
      %{valid?: false, errors: errors} -> {:error, errors}
    end
  end
end
