defmodule RPNCalculator do
  def calculate!(stack, operation) do
    operation.(stack)
  end

  def calculate(stack, operation) do
    try do
      res = calculate!(stack, operation)
      {:ok, res}
    rescue
      _ -> :error
    end
  end

  def calculate_verbose(stack, operation) do
    try do
      res = calculate!(stack, operation)

      {:ok, res}
    rescue
      e -> {:error, e.message}
    end
  end
end
