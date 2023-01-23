defmodule PheonixTest.ContentTest do
  use PheonixTest.DataCase

  alias PheonixTest.Content

  describe "quotations" do
    alias PheonixTest.Content.Quotation

    import PheonixTest.ContentFixtures

    @invalid_attrs %{author: nil, text: nil}

    test "list_quotations/0 returns all quotations" do
      quotation = quotation_fixture()
      assert Content.list_quotations() == [quotation]
    end

    test "get_quotation!/1 returns the quotation with given id" do
      quotation = quotation_fixture()
      assert Content.get_quotation!(quotation.id) == quotation
    end

    test "create_quotation/1 with valid data creates a quotation" do
      valid_attrs = %{author: "some author", text: "some text"}

      assert {:ok, %Quotation{} = quotation} = Content.create_quotation(valid_attrs)
      assert quotation.author == "some author"
      assert quotation.text == "some text"
    end

    test "create_quotation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_quotation(@invalid_attrs)
    end

    test "update_quotation/2 with valid data updates the quotation" do
      quotation = quotation_fixture()
      update_attrs = %{author: "some updated author", text: "some updated text"}

      assert {:ok, %Quotation{} = quotation} = Content.update_quotation(quotation, update_attrs)
      assert quotation.author == "some updated author"
      assert quotation.text == "some updated text"
    end

    test "update_quotation/2 with invalid data returns error changeset" do
      quotation = quotation_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_quotation(quotation, @invalid_attrs)
      assert quotation == Content.get_quotation!(quotation.id)
    end

    test "delete_quotation/1 deletes the quotation" do
      quotation = quotation_fixture()
      assert {:ok, %Quotation{}} = Content.delete_quotation(quotation)
      assert_raise Ecto.NoResultsError, fn -> Content.get_quotation!(quotation.id) end
    end

    test "change_quotation/1 returns a quotation changeset" do
      quotation = quotation_fixture()
      assert %Ecto.Changeset{} = Content.change_quotation(quotation)
    end
  end
end
