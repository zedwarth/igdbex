defmodule IgdbexTest do
  use ExUnit.Case
  doctest Igdbex

  import Igdbex

  test "process_url/1" do
    url = process_url("games")
    expected = "https://www.igdb.com/api/v1/games"
    assert url == expected
  end

  test "process_request_headers/1 with empty list" do
    headers = process_request_headers([])
    expected = [{"Authorization", "Token token=\"5upp3r-53cr3t-k3y\""}]
    assert headers == expected
  end
  test "process_response_body/1" do
    body = process_response_body(~s({"someProperty": "some value"}))
    expected = %{"someProperty" => "some value"}
    assert body == expected
  end
end
