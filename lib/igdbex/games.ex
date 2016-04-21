defmodule Igdbex.Games do
  @moduledoc """
  Make request under the `https://www.igdb.com/api/v1/games` resource.
  """

  import Igdbex

  @prefix "games"

  def games do
    get("games")
  end

  def games(query_params) do
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

  def search(query) do
    get("games/search?q=#{query}")
  end
end
