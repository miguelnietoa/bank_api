defmodule BankAPI.Accounts.Commands.OpenAccount do
  use Vex.Struct

  @enforce_keys [:account_uuid]

  defstruct [:account_uuid, :initial_balance]

  validates :account_uuid, presence: true, uuid: true
  validates :initial_balance, presence: true, number: [greater_than: 0]

  @spec validate(%__MODULE__{}) :: any()
  def validate(command), do: Vex.validate(command)
end
