defmodule BankAPI.CommandedApplication do
  use Commanded.Application, otp_app: :bank_api

  def init(config) do
    {:ok, config}
  end
end
