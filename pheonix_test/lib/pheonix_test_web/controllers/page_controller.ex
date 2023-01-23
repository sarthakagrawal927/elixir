defmodule PheonixTestWeb.PageController do
  use PheonixTestWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
