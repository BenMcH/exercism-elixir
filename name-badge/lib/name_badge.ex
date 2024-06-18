defmodule NameBadge do
  def print(id, name, department) do
    badge = if id, do: "[#{id}] - ", else: ""
    badge = badge <> "#{name} - "

    badge <> if department, do: String.upcase(department), else: "OWNER"
  end
end
