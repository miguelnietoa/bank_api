defmodule BankAPI.Accounts.Commands.CloseAccount do
  use Vex.Struct

  @enforce_keys [:account_uuid]

  defstruct [:account_uuid]

  validates :account_uuid, presence: true, uuid: true

  @spec validate(%__MODULE__{}) :: any()
  def validate(command), do: Vex.validate(command)
end
