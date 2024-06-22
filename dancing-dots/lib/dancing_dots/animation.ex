defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer

  @callback init(arg :: opts()) :: {:ok, opts()} | {:error, error()}

  @callback handle_frame(dot :: dot(), number :: frame_number(), opts :: opts()) :: dot()

  defmacro __using__(_) do
    quote do
      @behaviour DancingDots.Animation

      def init(arg), do: {:ok, arg}
      defoverridable init: 1
    end
  end
end

defmodule DancingDots.Flicker do
  use DancingDots.Animation

  @impl DancingDots.Animation
  def handle_frame(dot, number, _) when rem(number, 4) === 0 do
    %DancingDots.Dot{dot | opacity: dot.opacity / 2}
  end
  @impl DancingDots.Animation
  def handle_frame(dot, _, _), do: dot
end

defmodule DancingDots.Zoom do
  use DancingDots.Animation

  @impl DancingDots.Animation
  def init(opts) do
    velocity = Keyword.get(opts, :velocity)

    if is_integer(velocity) do
      {:ok, opts}
    else
      {:error, "The :velocity option is required, and its value must be a number. Got: #{inspect(velocity)}"}
    end
  end

  @impl DancingDots.Animation
  def handle_frame(dot, number, opts) do
     %DancingDots.Dot{dot | radius: do_calculate_radius(dot.radius, Keyword.get(opts, :velocity), number)}
  end

  defp do_calculate_radius(radius, velocity, target)
  defp do_calculate_radius(radius, _, 1), do: radius
  defp do_calculate_radius(radius, velocity, n), do: radius + (n - 1) * velocity
end
