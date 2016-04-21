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

  @doc """
  When the query is a filter, takes a tuple representing a query and returns
  the string to be appended to a request.

  ## Example
  iex> Igdbex.parse_query({:filter, {"ratings_gt", 6}})
  "&filters[ratings_gt]=6"

  iex> Igdbex.parse_query({:filter, {"platforms.id_eq", 70})
  "filters[platforms.id_eq]=70"
  """
  def parse_query({:filter, {filter, value}}) do
    value = value
            |> to_string
            |> String.replace(" ", "+")

    "&filters[#{filter}]=#{value}"
  end

  @doc """
  Takes a tuple representing a query and returns the string to be appended
  to a request.

  ## Example
    iex> Igdbex.parse_query({:offset, 26})
    "&offset=26"

    iex> Igdbex.parse_query({:powerlevel, "Over Nine Thousand"})
    "&powerlevel=Over+Nine+Thousand"
  """
  def parse_query({key, value}) do
    value = value
            |> to_string
            |> String.replace(" ", "+")

    "&#{key}=#{value}"
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
