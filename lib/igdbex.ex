defmodule Igdbex do
  use Application
  use HTTPoison.Base

  @moduledoc """
  Wrapper for the https://www.igdb.com API.
  """

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Define workers and child supervisors to be supervised
      # worker(Igdbex.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Igdbex.Supervisor]
    Supervisor.start_link(children, opts)
  end


  @endpoint "https://www.igdb.com/api/v1/"
  @key Application.get_env(:igdbex, :api_key)

  @doc """
  Prepends the full endpoint to the request so only the resource needs
  to be called in `Igdbex.get/3` or `Igdbex.get!/3`.

  ## Example
      iex>  Igdbex.process_url("games")
      "https://www.igdb.com/api/v1/games"
  """
  def process_url(url) do
    @endpoint <> url
  end

  def process_request_headers(headers) do
    [{"Authorization", "Token token=\"#{@key}\""}] ++ headers
  end

  def process_response_body(body) do
    body
    |> Poison.decode!
  end
end
