defmodule KitchenCalculator do
  def get_volume(volume_pair) do
    {_, vol} = volume_pair

    vol
  end

  def to_milliliter({:cup, volume}), do: {:milliliter, 240 * volume}
  def to_milliliter({:fluid_ounce, volume}), do: {:milliliter, 30 * volume}
  def to_milliliter({:teaspoon, volume}), do: {:milliliter,  5 * volume}
  def to_milliliter({:tablespoon, volume}), do: {:milliliter, 15 * volume}
  def to_milliliter({:milliliter, volume}), do: {:milliliter, volume}

  def from_milliliter({:milliliter, volume}, unit) when unit == :cup, do: {:cup, volume / 240}
  def from_milliliter({:milliliter, volume}, unit) when unit == :fluid_ounce, do: {:fluid_ounce, volume / 30}
  def from_milliliter({:milliliter, volume}, unit) when unit == :teaspoon, do: {:teaspoon,  volume / 5}
  def from_milliliter({:milliliter, volume}, unit) when unit == :tablespoon, do: {:tablespoon, volume / 15}
  def from_milliliter({:milliliter, volume}, unit) when unit == :milliliter, do: {:milliliter, volume}

  def convert(volume_pair, unit) do
    to_milliliter(volume_pair) |> from_milliliter(unit)
  end
end
