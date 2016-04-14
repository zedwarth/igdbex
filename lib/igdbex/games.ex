defmodule Igdbex.Games do
  @moduledoc """
  Make request under the `https://www.igdb.com/api/v1/games` resource.
  """

  import Igdbex.Base

  def games do
    get("games")
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
