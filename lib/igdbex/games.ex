defmodule Igdbex.Games do
  use HTTPoison.Base

  @endpoint "https://www.igdb.com/api/v1/"
  @key Application.get_env(:igdbex, :api_key)
  @expected_fields ~w(
  game id name alternative_name rating release_dates platform_name 
  release_date companies developer publisher name cover 
  screenshots subtile src
  )

  def games do
    get("games")
  end

  def meta do
    get("games/meta")
  end

  def id(game_id) do
    get("games/#{game_id}")
  end

  def search(query) do
    get("games/search?q=#{query}")
  end

  defp process_url(url) do
    @endpoint <> url
  end

  defp process_request_headers(headers) do
    [{"Authorization", 'Token token="#{@key}"'}] ++ headers
  end

  defp process_response_body(body) do
    body
    |> Poison.decode!
    |> Dict.take(@expected_fields)
    |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
  end
end
