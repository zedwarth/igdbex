defmodule Igdbex.GamesTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  import Igdbex.Games

  setup_all do
    HTTPoison.start
  end

  test "games/0" do
    use_cassette "games_get" do
      {:ok, %HTTPoison.Response{body: body}} = games
      first_game_id = List.first(body["games"])["id"]
      assert first_game_id == 1
    end
  end

  test "meta/0" do
    use_cassette "games_meta_get" do
      {:ok, %HTTPoison.Response{body: body}} = meta
      assert body["size"] > 17815
    end
  end

  test "game/1" do
    use_cassette "games_id_get" do
      {:ok, %HTTPoison.Response{body: body}} = game("3192")
      assert body["game"]["name"] == "Sonic The Hedgehog"
    end
  end

  test "search/1" do
    use_cassette "games_search_get" do
      {:ok, %HTTPoison.Response{body: body}} = search("bloodborne")
      game = List.first(body["games"])["name"]
      assert game == "Bloodborne"
    end
  end
end
