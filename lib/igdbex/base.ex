defmodule Igdbex.Base do
  @moduledoc """
  Igbex wrapper for HTTPoison.

  - Sets endpoint
  - Adds API Token to request headers
  - Process response body with Poison
  """

  use HTTPoison.Base

  @endpoint "https://www.igdb.com/api/v1/"
  @key Application.get_env(:igdbex, :api_key)

  defp process_url(url) do
    @endpoint <> url
  end

  defp process_request_headers(headers) do
    [{"Authorization", "Token token=\"#{@key}\""}] ++ headers
  end

  defp process_response_body(body) do
    body
    |> Poison.decode!
  end
end
