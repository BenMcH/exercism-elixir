defmodule LogLevel do
  def to_label(level, legacy?) do
    case {level, legacy?} do
      {0, false} -> :trace
      {1, _} -> :debug
      {2, _} -> :info
      {3, _} -> :warning
      {4, _} -> :error
      {5, false} -> :fatal
      {_, _} -> :unknown
    end
  end

  def alert_recipient(level, legacy?) do
    log_level = to_label(level, legacy?)

    cond do
      log_level == :unknown and legacy? -> :dev1
      log_level == :unknown and not legacy? -> :dev2
      Enum.any?([:error, :fatal], &(&1==log_level)) -> :ops
      true -> false
    end

  end
end
