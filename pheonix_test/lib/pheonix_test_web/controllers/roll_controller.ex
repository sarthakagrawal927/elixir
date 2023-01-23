defmodule PheonixTestWeb.RollController do
  use PheonixTestWeb, :controller

  def index(conn, _params) do
    render(conn, "index.json", roll: %{value: :rand.uniform(6)})
  end

  def show(conn, %{"num_dice" => num_dice}) do
    rolls =
      case Integer.parse(num_dice) do
        {num, _} -> for x <- 1..num, do: %{die: x, value: :rand.uniform(6)}
        _ -> :error
      end

    render(conn, "show.json", rolls: rolls)
  end
end
