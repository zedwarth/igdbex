defmodule Igdbex.Games do
  @moduledoc """
  Make request under the `https://www.igdb.com/api/v1/games` resource.
  """

  import Igdbex

  @prefix "games"

  def games do
    get("games")
  end

  def games([]) do
    games
  end

  def games(query_params) when query_params |> is_list do
    query_params
    |> Enum.map(&parse_query/1)
    |> Enum.reduce(fn(x, acc) -> acc <> x end)
    |> String.replace_prefix("&", @prefix <> "?")
    |> get
  end

  def meta do
    get("games/meta")
  end

  def game(id) do
    get("games/#{id}")
  end

  @doc """
  See the IGDB API documentation for more information.
  https://www.igdb.com/api/v1/documentation/games#games_search_get
  """
  def search(query_params) when query_params |> is_list do
    query_params
    |> Enum.map(&parse_query/1)
    |> Enum.reduce(fn(x, acc) -> acc <> x end)
    |> String.replace_prefix("&", @prefix <> "/search?")
    |> get
  end

  def search(query) do
    get("games/search?q=#{query}")
  end
end
