defmodule PheonixTest.ContentFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PheonixTest.Content` context.
  """

  @doc """
  Generate a quotation.
  """
  def quotation_fixture(attrs \\ %{}) do
    {:ok, quotation} =
      attrs
      |> Enum.into(%{
        author: "some author",
        text: "some text"
      })
      |> PheonixTest.Content.create_quotation()

    quotation
  end
end
