defmodule Igdbex.Companies do
  @moduledoc """
  Make request under the `https://www.igdb.com/api/v1/companies` resource.
  """
  import Igdbex

  @prefix "companies"

  def companies do
    get(@prefix)
  end

  def companies([]) do
    companies
  end

  def companies(query_params) when query_params |> is_list do
    query_params
    |> Enum.map(&parse_query/1)
    |> Enum.reduce(fn(x, acc) -> acc <> x end)
    |> String.replace_prefix("&", @prefix <> "?")
    |> get
  end

  def company(id) do
    get(@prefix <> "/#{id}")
  end

  def meta do
    get(@prefix <> "/meta")
  end

  def companies_games(id) do
    get(@prefix <> "/#{id}/games")
  end
end
