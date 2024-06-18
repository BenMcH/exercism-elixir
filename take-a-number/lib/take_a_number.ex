defmodule TakeANumber do
  def start() do
    spawn(&loop/0)
  end

  defp loop(num \\ 0) do
    receive do
      {:report_state, pid} ->
        send(pid, num)
        loop(num)
      {:take_a_number, pid} ->
        send(pid, num+1)
        loop(num+1)
      :stop -> :stop
      _ -> loop(num)
    end
  end
end
