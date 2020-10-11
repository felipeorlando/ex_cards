defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @doc """
    Create an entire deck of cards
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "King", "Queen", "Jack"]
    suits = ["Hearts", "Spades", "Diamonds", "Clubs"]

    for value <- values, suit <- suits do
      "#{value} of #{suit}"
    end
  end

  @doc """
    Receive a deck and returns it shuffled/randomized
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Returns if exist a card in a passed deck

  ## Examples

      iex> deck = Cards.create_deck()
      iex> Cards.contains?(deck, "Ace of Spades")
      true
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Returns a hand (list of cards) of a specified number of cards and the rest of the provided deck

  ## Examples

      iex> deck = Cards.create_deck()
      iex> {first_card, _rest} = Cards.deal(deck, 1)
      iex> first_card
      ["Ace of Hearts"]
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
    Saves deck of cards to a binary file
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
    Loads a deck of cards from a binary file
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, reason} -> deal_with_load_error(reason)
    end
  end

  @doc """
    Creates and pass a hand of passed number of cards and the rest of the deck
  """
  def create_hand(hand_size) do
    create_deck()
    |> shuffle()
    |> deal(hand_size)
  end

  defp deal_with_load_error(reason) do
    case reason do
      :enoent ->
        "The file does not exist"
      :eacces ->
        "Missing permission for reading the file, or for searching one of the parent directories"
      :eisdir ->
        "The named file is a directory"
      :enotdir ->
        "A component of the file name is not a directory"
      _ ->
        "An error occurred"
    end
  end
end
