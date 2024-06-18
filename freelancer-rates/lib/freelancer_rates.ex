defmodule FreelancerRates do
  def daily_rate(hourly_rate) do
    8.0 * hourly_rate
  end

  def apply_discount(before_discount, discount) do
    before_discount * (1 - discount / 100)
  end

  def monthly_rate(hourly_rate, discount) do
    ceil(
      apply_discount(
        daily_rate(hourly_rate) * 22,
        discount
      )
    )
  end

  def days_in_budget(budget, hourly_rate, discount) do
    daily = apply_discount(daily_rate(hourly_rate), discount)

    Float.floor(budget / daily, 1)
  end
end
