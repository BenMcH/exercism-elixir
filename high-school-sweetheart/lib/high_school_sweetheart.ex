defmodule HighSchoolSweetheart do
  def first_letter(name) do
    name |>
    String.trim() |>
    String.at(0)
  end

  def initial(name) do
    name |>
    first_letter() |>
    String.upcase() |>
    Kernel.<>(".")
  end

  def initials(full_name) do
    [first, last] = full_name |>
      String.split(" ") |>
      Enum.map(&initial/1)

    first = first <> " "

    first <> last
  end

  def pair(full_name1, full_name2) do
    on = initials(full_name1)
    tw = initials(full_name2)
    """
         ******       ******
       **      **   **      **
     **         ** **         **
    **            *            **
    **                         **
    **     #{on}  +  #{tw}     **
     **                       **
       **                   **
         **               **
           **           **
             **       **
               **   **
                 ***
                  *
    """
  end
end
