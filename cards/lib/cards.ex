# elixir gets transpiled to Erlang -> Compiled & executed in BEAM (VM named after the creators)

defmodule Cards do
  @moduledoc """
    Provides methods for creating & handling a deck of cards
  """

  @doc """
    Returns a list of string representing a deck
  """
  def create do
    values = ["Ace", "King", "Queen", "Jester", "Ten"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    # Solution 1
    List.flatten(
      for suit <- suits do
        for value <- values do
          "#{suit} of #{value}"
        end
      end
    )

    # Solution 2
    for suit <- suits, value <- values do
      "#{suit} of #{value}"
    end
  end

  # deck is immutable
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  # adds question to tell developers this returns bool
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into a hand & remainder of deck. The `hand_size` argument indicates how many cards in a deck

    ## Examples

      iex> deck = Cards.create()
      iex> Cards.deal(deck, 1)
      ["Spades of Ace"]
  """
  def deal(deck, hand_size) do
    # splits the array into 2 (tuple), 1st having the size of hand_size
    # Pattern matching is elixir's replacement for variable assignment
    {hand, _rest_of_deck} = Enum.split(deck, hand_size)
    hand
  end

  def save(deck, filename) do
    File.write(filename, :erlang.term_to_binary(deck))
  end

  def load(filename) do
    case File.read(filename) do
      # any variable that starts with : are called atom -> they are like strings used throughout elixir as status codes
      {:ok, binaryData} -> :erlang.binary_to_term(binaryData)
      {:error, _reason} -> "File does not exist"
    end
  end

  def create_hand(hand_size) do
    # One way
    deck = create()
    deck = shuffle(deck)
    deal(deck, hand_size)

    # Elixir way -> pipes down result to next operation, wants us to make very consistent first arguments
    create() |> shuffle() |> deal(hand_size)
  end
end
