defmodule Cards do
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "King", "Queen", "Jack"]
    suits = ["Hearts", "Spades", "Diamonds", "Clubs"]

    for value <- values, suit <- suits do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, reason} -> deal_with_load_error(reason)
    end
  end

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
