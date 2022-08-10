defmodule BankAPI.Accounts.Commands.TransferBetweenAccounts do
  use Vex.Struct

  @enforce_keys [:account_uuid, :transfer_uuid]

  defstruct [:account_uuid, :transfer_uuid, :transfer_amount, :destination_account_uuid]

  alias BankAPI.{Accounts, Accounts.Projections.Account}

  validates(:account_uuid, presence: true, uuid: true)
  validates(:transfer_uuid, presence: true, uuid: true)
  validates(:transfer_amount, presence: true, number: [greater_than: 0])
  validates(:destination_account_uuid, presence: true, uuid: true)

  @spec validate(%__MODULE__{}) :: any()
  def validate(%__MODULE__{destination_account_uuid: destination_account_uuid} = command) do
    case Accounts.get_account(destination_account_uuid) do
      {:ok, %Account{status: "open"}} -> Vex.validate(command)
      {:ok, %Account{status: "closed"}} -> {:error, ["Destination account closed"]}
      {:error, :not_found} -> {:error, ["Destination account does not exist"]}
    end
  end
end
