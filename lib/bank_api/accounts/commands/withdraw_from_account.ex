defmodule BankAPI.Accounts.Commands.WithdrawFromAccount do
  use Vex.Struct

  @enforce_keys [:account_uuid]

  defstruct [:account_uuid, :withdraw_amount]

  validates :account_uuid, presence: true, uuid: true
  validates :withdraw_amount, presence: true, number: [greater_than: 0]

  @spec validate(%__MODULE__{}) :: any()
  def validate(command), do: Vex.validate(command)
end
