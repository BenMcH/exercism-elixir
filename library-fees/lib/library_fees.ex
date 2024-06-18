defmodule LibraryFees do
  def datetime_from_string(string) do
    {:ok, date} = NaiveDateTime.from_iso8601(string)
    date
  end

  def before_noon?(datetime), do: Time.before?(datetime, ~T[12:00:00])

  def return_date(checkout_datetime) do
    if before_noon?(checkout_datetime) do
      Date.add(checkout_datetime, 28)
    else
      Date.add(checkout_datetime, 29)
    end
  end

  def days_late(planned_return_date, actual_return_datetime) do
    if Date.after?(planned_return_date, actual_return_datetime) do
      0
    else
      Date.diff(actual_return_datetime, planned_return_date)
    end
  end

  def monday?(datetime) do
    Date.day_of_week(datetime, :monday) == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    checkout = datetime_from_string(checkout)
    return = datetime_from_string(return)

    late_days =
      return_date(checkout)
      |> days_late(return)

    cond do
      late_days == 0 -> 0
      monday?(return) -> floor(late_days / 2 * rate)
      true -> late_days * rate
    end
  end
end
