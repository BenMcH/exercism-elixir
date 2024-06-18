defmodule BoutiqueInventory do
  def sort_by_price(inventory), do: Enum.sort_by(inventory, & &1[:price])

  def with_missing_price(inventory), do: Enum.filter(inventory, & &1[:price] === nil)

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, & %{&1 | name: String.replace(&1[:name], old_word, new_word)})
  end

  def increase_quantity(item, count) do
    quantities = Map.new(item[:quantity_by_size], fn {key, value} ->
      {key, value + count}
    end)

    %{item | quantity_by_size: quantities}
  end

  def total_quantity(item) do
    Enum.reduce(item[:quantity_by_size], 0, & elem(&1, 1) + &2)
  end
end
