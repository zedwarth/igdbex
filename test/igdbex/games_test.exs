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

  test "games/1 with empty list" do
    use_cassette "games_get" do
      {:ok, %HTTPoison.Response{body: body}} = games([])
      first_game_id = List.first(body["games"])["id"]
      assert first_game_id == 1
    end
  end

  test "games/1 with offset" do
    use_cassette "games_with_offset_get" do
      query = [offset: 25]
      {:ok, %HTTPoison.Response{body: body}} = games(query)
      twenty_sixth_game_id = List.first(body["games"])["id"]
      assert twenty_sixth_game_id == 26
    end
  end

  test "games/1 with limit" do
    use_cassette "games_with_limit_get" do
      query = [limit: 10]
      {:ok, %HTTPoison.Response{body: body}} = games(query)
      tenth_game_id  = List.last(body["games"])["id"]
      assert tenth_game_id == 10
    end
  end

  test "games/1 with offset and limit" do
    use_cassette "games_with_offset_and_limit_get" do
      query = [offset: 10, limit: 10]
      {:ok, %HTTPoison.Response{body: body}} = games(query)
      twentith_game_id  = List.last(body["games"])["id"]
      assert twentith_game_id == 20
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

  test "search/1 with filter" do
    use_cassette "games_search_with_filter" do
      query_params = [q: "Assassin's Creed", filter: {"platforms.id_eq", 48}]
      {:ok, %HTTPoison.Response{body: body}} = search(query_params)
      game = List.first(body["games"])["name"]
      assert game == "Assassin's Creed: Syndicate"
    end
  end

  test "search/1 with filters" do
    use_cassette "games_search_with_filters" do
      query_params = [filter: {"platforms.id_eq", 78}, filter: {"ratings_gt", 8}]
      {:ok, %HTTPoison.Response{body: body}} = search(query_params)
      game = List.first(body["games"])["name"]
      assert game == "Wing Commander"
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
