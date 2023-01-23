defmodule PheonixTestWeb.RollView do
  use PheonixTestWeb, :view

  def render("index.json", %{roll: roll}) do
    %{data: render_one(roll, __MODULE__, "roll.json")}
  end

  def render("roll.json", %{roll: %{die: die, value: num}}) when is_integer(num) do
    %{value: num, die: die}
  end

  def render("roll.json", _) do
    %{status: "error"}
  end

  def render("show.json", %{rolls: rolls}) do
    %{data: render_many(rolls, __MODULE__, "roll.json")}
  end
end
