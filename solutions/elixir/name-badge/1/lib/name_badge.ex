defmodule NameBadge do
  def print(id, name, department) do
    actual_id = if id, do: "[#{id}] - ", else: ""
    actual_dept = if department, do: " - #{String.upcase(department)}", else: " - OWNER"
    "#{actual_id}#{name}#{actual_dept}"
  end
end
