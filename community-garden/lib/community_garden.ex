# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    Agent.start(fn -> {[], 1} end, opts)
  end

  def list_registrations(pid), do: Agent.get(pid, fn {regs, _} -> regs end)

  def register(pid, register_to) do
    {plots, _} = Agent.get_and_update(pid, fn {plots, id} ->
      plot = %Plot{plot_id: id, registered_to: register_to}
      new = {plots ++ [plot], id + 1}

      {new, new}
    end)

    List.last(plots)
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn {plots, id} ->
      plots = Enum.filter(plots, & &1.plot_id !== plot_id)
      {plots, id}
    end)
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn {plots, _} -> Enum.find(plots, & &1.plot_id == plot_id) end) || {:not_found, "plot is unregistered"}
  end
end
