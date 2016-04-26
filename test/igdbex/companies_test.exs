defmodule Igdbex.CompaniesTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  import Igdbex.Companies

  setup_all do
    HTTPoison.start
  end
  
  test "companies/0" do
    use_cassette "companies_get" do
      {:ok, %HTTPoison.Response{body: body}} = companies
      first_company_id = List.last(body["companies"])["id"]
      assert first_company_id == 2562
    end
  end

  test "companies/1 with empty list" do
    use_cassette "companies_get" do
      {:ok, %HTTPoison.Response{body: body}} = companies([])
      first_company_id = List.last(body["companies"])["id"]
      assert first_company_id == 2562
    end
  end

  test "companies/1 with offset" do
    use_cassette "companies_with_offset_get" do
      query = [offset: 25]
      {:ok, %HTTPoison.Response{body: body}} = companies(query)
      twenty_sixth_company_id = List.first(body["companies"])["id"]
      assert twenty_sixth_company_id == 8787
    end
  end

  test "companies/1 with limit" do
    use_cassette "companies_with_limit_get" do
      query = [limit: 10]
      {:ok, %HTTPoison.Response{body: body}} = companies(query)
      tenth_company_id  = List.last(body["companies"])["id"]
      assert tenth_company_id == 5913
    end
  end

  test "companies/1 with offset and limit" do
    use_cassette "companies_with_offset_and_limit_get" do
      query = [offset: 10, limit: 10]
      {:ok, %HTTPoison.Response{body: body}} = companies(query)
      twentith_company_id  = List.last(body["companies"])["id"]
      assert twentith_company_id == 2493
    end
  end

  test "company/1" do
    use_cassette "company_get" do
      {:ok, %HTTPoison.Response{body: body}} = company(73)
      assert body["company"]["name"] == "Aspyr Media"
    end
  end

  test "meta/0" do
    use_cassette "companies_meta_get" do
      {:ok, %HTTPoison.Response{body: body}} = meta
      assert body["size"] > 9410
    end
  end

  test "companies_games/1" do
    use_cassette "companies_games_get" do
      {:ok, %HTTPoison.Response{body: body}} = companies_games(104)
      twenty_fith_game = List.last(body["games"])["id"]
      assert twenty_fith_game == 8216
    end
  end
end
