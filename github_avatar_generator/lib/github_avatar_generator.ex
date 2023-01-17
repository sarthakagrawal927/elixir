defmodule GithubAvatarGenerator do
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
    |> draw_image
    |> save_image(input)
  end

  # elixir's pattern match making
  def pick_color(%GithubAvatarGenerator.Image{hex: [red, green, blue | _tail]} = image) do
    # destructure image & add this property
    %GithubAvatarGenerator.Image{image | color: {red, green, blue}}
  end

  def hash_input(input) do
    # returns list of number
    # numbers range between 0,255
    hex = :crypto.hash(:md5, input) |> :binary.bin_to_list()
    %GithubAvatarGenerator.Image{hex: hex}
  end

  def build_grid(%GithubAvatarGenerator.Image{hex: hex_list} = image) do
    # in elixir a function is invoked by default so we have to pass the reference along with the number of arguments
    %GithubAvatarGenerator.Image{
      image
      | grid:
          hex_list
          |> Enum.chunk(3)
          |> Enum.map(&mirror_row/1)
          |> List.flatten()
          |> Enum.with_index()
    }
  end

  def filter_odd_squares(%GithubAvatarGenerator.Image{grid: grid} = image) do
    %GithubAvatarGenerator.Image{
      image
      | grid:
          Enum.filter(grid, fn {code, _idx} ->
            rem(code, 2) == 0
          end)
    }
  end

  def build_pixel_map(%GithubAvatarGenerator.Image{grid: grid} = image) do
    %GithubAvatarGenerator.Image{
      image
      | pixel_map:
          Enum.map(grid, fn {_code, index} ->
            horizontal = rem(index, 5) * 50
            vertical = div(index, 5) * 50
            top_left = {horizontal, vertical}
            bottom_right = {horizontal + 50, vertical + 50}
            {top_left, bottom_right}
          end)
    }
  end

  def draw_image(%GithubAvatarGenerator.Image{pixel_map: pixel_map, color: color}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)

    Enum.each(pixel_map, fn {start, stop} ->
      :egd.filledRectangle(image, start, stop, fill)
    end)

    image

    :egd.render(image)
  end

  def mirror_row(row) do
    [first, second | _tail] = row
    # concat array
    row ++ [second, first]
  end

  def save_image(image, input) do
    File.write("#{input}.png", image)
  end
end
