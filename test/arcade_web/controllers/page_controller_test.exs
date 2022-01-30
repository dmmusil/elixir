defmodule ArcadeWeb.PageControllerTest do
  use ArcadeWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Recent posts"
  end
end
