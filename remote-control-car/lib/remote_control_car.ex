defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:nickname, battery_percentage: 100, distance_driven_in_meters: 0]

  def new(nickname \\ "none")
  def new(nickname), do: %RemoteControlCar{nickname: nickname}

  def display_distance(%RemoteControlCar{} = remote_car), do: "#{remote_car.distance_driven_in_meters} meters"

  def display_battery(remote_car)
  def display_battery(%RemoteControlCar{battery_percentage: 0}), do: "Battery empty"
  def display_battery(%RemoteControlCar{} = remote_car), do: "Battery at #{remote_car.battery_percentage}%"

  def drive(remote_car)
  def drive(%RemoteControlCar{battery_percentage: 0} = car), do: car
  def drive(%RemoteControlCar{} = remote_car) do
    %RemoteControlCar{
      remote_car |
      battery_percentage: remote_car.battery_percentage - 1,
      distance_driven_in_meters: remote_car.distance_driven_in_meters + 20
    }
  end
end
