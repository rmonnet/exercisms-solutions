defmodule RPG.CharacterSheet do
  def welcome() do
    IO.puts("Welcome! Let's fill out your character sheet together.")
    :ok
  end

  def ask_name() do
    name = IO.gets("What is your character's name?\n")
    String.trim(name)
  end

  def ask_class() do
    class = IO.gets("What is your character's class?\n")
    String.trim(class)
  end

  def ask_level() do
    level_as_str = IO.gets("What is your character's level?\n")
    {level, _} = Integer.parse(level_as_str)
    level
  end

  def run() do
    welcome()
    name = ask_name()
    class = ask_class()
    level = ask_level()
    sheet = %{name: name, class: class, level: level}
    IO.inspect(sheet, label: "Your character: ")
    sheet
  end
end
