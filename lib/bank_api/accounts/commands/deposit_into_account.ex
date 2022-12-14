defmodule BankAPI.Accounts.Commands.DepositIntoAccount do
  use Vex.Struct

  @enforce_keys [:account_uuid]

  defstruct [:account_uuid, :transfer_uuid, :deposit_amount]

  validates :account_uuid, presence: true, uuid: true
  validates :transfer_uuid, uuid: [format: :default, allow_nil: true]
  validates :deposit_amount, presence: true, number: [greater_than: 0]

  @spec validate(%__MODULE__{}) :: any()
  def validate(command), do: Vex.validate(command)
end
