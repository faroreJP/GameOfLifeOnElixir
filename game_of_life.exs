#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# Faore, Sep 4, 2016
# Module for Game of Life
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
defmodule LifeGame do

  #-------------------------------------------------------------
  # Public Usage
  #-------------------------------------------------------------

  # Make Map
  def make_map(lifemap) do
    make_map(lifemap, lifemap[:w] * lifemap[:h])
  end

  # Update Map
  def update(life) do
    IO.gets ""

    update_cell(life, life, life[:w] * life[:h])
    |> print_map()
    |> update()
  end

  # Print Map
  def print_map(life) do
    print_map(life, life[:w] * life[:h])
    life
  end

  #-------------------------------------------------------------
  # Private Functions
  #-------------------------------------------------------------

  defp make_map(life, 1) do
    Map.put(life, 1, false)
  end
  defp make_map(life, n) do
    make_map(life, n - 1)
    |> Map.put(n, false)
  end

  defp update_cell(life, prelife, 1) do
    count = count_live(prelife, 1)

    judge({count, prelife[1]})
    |> put_cell(life, 1)
  end
  defp update_cell(life, prelife, index) do
    lifemap = update_cell(life, prelife, index - 1)
    count   = count_live(prelife, index)

    judge({count, lifemap[index]})
    |> put_cell(lifemap, index)
  end

  defp count_live(life, index) do
    cond do
      rem(index, life[:w]) == 0 -> 
        check(0, life[index - life[:w] - 1])
        |> check(life[index - life[:w]])
        |> check(life[index - 1])
        |> check(life[index + life[:w] - 1])
        |> check(life[index + life[:w]])
      rem(index - 1, life[:w]) == 0 ->
        check(0, life[index - life[:w] + 1])
        |> check(life[index - life[:w]])
        |> check(life[index + 1])
        |> check(life[index + life[:w] + 1])
        |> check(life[index + life[:w]])
      true ->
        check(0, life[index - life[:w] - 1])
        |> check(life[index - life[:w]])
        |> check(life[index - life[:w] + 1])
        |> check(life[index - 1])
        |> check(life[index + 1])
        |> check(life[index + life[:w] - 1])
        |> check(life[index + life[:w]])
        |> check(life[index + life[:w] + 1])
    end
  end

  defp check(count, nil) do
    count
  end
  defp check(count, true) do
    count + 1
  end
  defp check(count, false) do
    count
  end

  defp judge({count, state}) do
    case {count, state} do
      {3, false} -> true 
      {0, true} -> false
      {1, true} -> false
      {2, true} -> true
      {3, true} -> true
      {_, _}    -> false
    end
  end

  defp print_map(life, 1) do
    print_cell(life[1])
  end
  defp print_map(life, n) do
    print_map(life, n - 1)

    print_cell(life[n])
    if rem(n, life[:w]) == 0 do
      IO.puts ""
    end
  end

  defp put_cell(state, life, index) do
    Map.put(life, index, state)
  end
  defp print_cell(cell) do
    case cell do
      true -> IO.write("x ")
      false -> IO.write("  ")
    end
  end
end

#-------------------------------------------------------------
# Entry Point
#-------------------------------------------------------------
LifeGame.make_map(%{w: 40, h: 40})

#-------------------------------------------------------------
#  Galaxy
|> Map.put(20 + 40 * 20, true)
|> Map.put(21 + 40 * 20, true)
|> Map.put(22 + 40 * 20, true)
|> Map.put(23 + 40 * 20, true)
|> Map.put(24 + 40 * 20, true)
|> Map.put(25 + 40 * 20, true)
|> Map.put(27 + 40 * 20, true)
|> Map.put(28 + 40 * 20, true)
|> Map.put(20 + 40 * 21, true)
|> Map.put(21 + 40 * 21, true)
|> Map.put(22 + 40 * 21, true)
|> Map.put(23 + 40 * 21, true)
|> Map.put(24 + 40 * 21, true)
|> Map.put(25 + 40 * 21, true)
|> Map.put(27 + 40 * 21, true)
|> Map.put(28 + 40 * 21, true)
|> Map.put(27 + 40 * 22, true)
|> Map.put(28 + 40 * 22, true)
|> Map.put(20 + 40 * 23, true)
|> Map.put(21 + 40 * 23, true)
|> Map.put(27 + 40 * 23, true)
|> Map.put(28 + 40 * 23, true)
|> Map.put(20 + 40 * 24, true)
|> Map.put(21 + 40 * 24, true)
|> Map.put(27 + 40 * 24, true)
|> Map.put(28 + 40 * 24, true)
|> Map.put(20 + 40 * 25, true)
|> Map.put(21 + 40 * 25, true)
|> Map.put(27 + 40 * 25, true)
|> Map.put(28 + 40 * 25, true)
|> Map.put(20 + 40 * 26, true)
|> Map.put(21 + 40 * 26, true)
|> Map.put(20 + 40 * 27, true)
|> Map.put(21 + 40 * 27, true)
|> Map.put(23 + 40 * 27, true)
|> Map.put(24 + 40 * 27, true)
|> Map.put(25 + 40 * 27, true)
|> Map.put(26 + 40 * 27, true)
|> Map.put(27 + 40 * 27, true)
|> Map.put(28 + 40 * 27, true)
|> Map.put(20 + 40 * 28, true)
|> Map.put(21 + 40 * 28, true)
|> Map.put(23 + 40 * 28, true)
|> Map.put(24 + 40 * 28, true)
|> Map.put(25 + 40 * 28, true)
|> Map.put(26 + 40 * 28, true)
|> Map.put(27 + 40 * 28, true)
|> Map.put(28 + 40 * 28, true)

#-------------------------------------------------------------
# Glider
# |> Map.put(40 * 50 - 1, true)
# |> Map.put(40 * 49 - 2, true)
# |> Map.put(40 * 48, true)
# |> Map.put(40 * 48 - 1, true)
# |> Map.put(40 * 48 - 2, true)

#-------------------------------------------------------------
# Die Hard
# |> Map.put(28 + 40 * 20, true) 
# |> Map.put(22 + 40 * 21, true) 
# |> Map.put(23 + 40 * 21, true) 
# |> Map.put(23 + 40 * 22, true) 
# |> Map.put(27 + 40 * 22, true) 
# |> Map.put(28 + 40 * 22, true) 
# |> Map.put(29 + 40 * 22, true) 

#-------------------------------------------------------------
# Main Loop
|> LifeGame.print_map()
|> LifeGame.update()
