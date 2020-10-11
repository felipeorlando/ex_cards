defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  describe "create_deck/1" do
    test "makes 52 cards" do
      deck_length = length(Cards.create_deck)
      assert deck_length == 52
    end
  end

  describe "shuffle/2" do
    test "gives a deck randomized" do
      deck = Cards.create_deck()
      refute deck == Cards.shuffle(deck)
    end
  end

  describe "contains?/2" do
    test "returns if a given deck has a specified card" do
      deck = Cards.create_deck()
      assert Cards.contains?(deck, "Ace of Spades") == true
    end
  end

  describe "deal/2" do
    test "returns a hand of a specified number of cards" do
      deck = Cards.create_deck()
      {first_card, _} = Cards.deal(deck, 1)

      assert first_card == ["Ace of Hearts"]
    end

    test "returns the rest of the provided deck" do
      deck = Cards.create_deck()
      {_, rest_of_deck} = Cards.deal(deck, 1)

      assert length(rest_of_deck) == 51
    end
  end

end
