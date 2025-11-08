defmodule NameBadge do
  def print(id, name, department) do
    badge_owner = if(department, do: :string.uppercase(department), else: "OWNER")
    if id do
      "[#{id}] - #{name} - #{badge_owner}"
    else
      "#{name} - #{badge_owner}"
    end
  end
end
