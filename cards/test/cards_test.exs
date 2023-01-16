defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck make 20 cards" do
    deck_length = length(Cards.create())
    assert deck_length == 20
  end

  test "shuffling a deck randomizes" do
    deck = Cards.create()
    refute deck == Cards.shuffle(deck)
  end
end
