defmodule ConsumindoApi.GithubTest do
  use ExUnit.Case, async: true

  setup do
    bypass = Bypass.open()
    {:ok, bypass: bypass}
  end

  describe "get_user_repos/1" do
    test "returns the user repos information", %{bypass: bypass} do
      url = endpoint_url(bypass.port)
      username = "valid_user"
      body = ~s(
        {
          "description": "Overlap2D - UI and Level Editor libgdx runtime",
          "html_url": "https://github.com/Blaud/overlap2d-runtime-html5-support",
          "id": 107087547,
          "name": "overlap2d-runtime-html5-support",
          "stargazers_count": 0
        },
        {
          "description": "Headless Chrome Node.js API",
          "html_url": "https://github.com/Blaud/puppeteer",
          "id": 228601994,
          "name": "puppeteer",
          "stargazers_count": 0
        }
        )

      Bypass.expect(bypass, "GET", "/users/#{username}/repos", fn conn ->
        Plug.Conn.resp(conn, 200, body)
      end)

      response = ConsumindoApi.Github.get_user_repos(url, username)

      assert response == {:ok, body}
    end

    test "handle not found response", %{bypass: bypass} do
      url = endpoint_url(bypass.port)
      invalid_user = "invalid_user"

      Bypass.expect(bypass, "GET", "/users/#{invalid_user}/repos", fn conn ->
        Plug.Conn.resp(conn, 404, "User not found")
      end)

      response = ConsumindoApi.Github.get_user_repos(url, invalid_user)

      assert response == {:error, "User not found"}
    end

    test "can handle internal server error from API", %{bypass: bypass} do
      url = endpoint_url(bypass.port)
      username = "any_user"

      Bypass.expect(bypass, "GET", "/users/#{username}/repos", fn conn ->
        Plug.Conn.resp(conn, 500, "User not found")
      end)

      response = ConsumindoApi.Github.get_user_repos(url, username)

      assert response == {:error, "Unexpected response from API"}
    end

    defp endpoint_url(port), do: "http://localhost:#{port}"
  end
end
