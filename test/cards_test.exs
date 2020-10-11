defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck/1 makes 52 cards" do
    deck_length = length(Cards.create_deck)
    assert deck_length == 52
  end

  test "shuffle/2 gives a deck randomized" do
    deck = Cards.create_deck()
    refute deck == Cards.shuffle(deck)
  end

  test "contains?/2 returns if a given deck has a specified card" do
    deck = Cards.create_deck()
    assert Cards.contains?(deck, "Ace of Spades") == true
  end

  test "deal/2 returns a hand of a specified number of cards and the rest of the provided deck" do
    deck = Cards.create_deck()
    {first_card, rest_of_deck} = Cards.deal(deck, 1)

    assert first_card == ["Ace of Hearts"]
    assert length(rest_of_deck) == 51
  end
end
