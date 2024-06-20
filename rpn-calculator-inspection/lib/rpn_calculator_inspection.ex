defmodule RPNCalculatorInspection do
  def start_reliability_check(calculator, input) do
    pid = spawn_link(fn -> calculator.(input) end)

    %{input: input, pid: pid}
  end

  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    result = receive do
      {:EXIT, ^pid, :normal} -> :ok
      {:EXIT, ^pid, _} -> :error
    after
      100 -> :timeout
    end

    Map.put(results, input, result)
  end

  def reliability_check(calculator, inputs) do
    trap = Process.flag(:trap_exit, true)

    inputs
    |> Enum.map(& start_reliability_check(calculator, &1))
    |> do_reliability_check()
    |> tap(fn _ -> Process.flag(:trap_exit, trap) end)
  end

  defp do_reliability_check(inputs, acc \\ %{})
  defp do_reliability_check([], acc), do: acc
  defp do_reliability_check([head | tail], acc) do
    acc = await_reliability_check_result(head, acc)
    do_reliability_check(tail, acc)
  end

  def correctness_check(calculator, inputs) do
    inputs
    |> Enum.map(& Task.async(fn -> calculator.(&1) end))
    |> Enum.map(& Task.await(&1, 100))
  end
end
