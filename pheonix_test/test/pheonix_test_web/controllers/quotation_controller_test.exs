defmodule PheonixTestWeb.QuotationControllerTest do
  use PheonixTestWeb.ConnCase

  import PheonixTest.ContentFixtures

  alias PheonixTest.Content.Quotation

  @create_attrs %{
    author: "some author",
    text: "some text"
  }
  @update_attrs %{
    author: "some updated author",
    text: "some updated text"
  }
  @invalid_attrs %{author: nil, text: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all quotations", %{conn: conn} do
      conn = get(conn, Routes.quotation_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create quotation" do
    test "renders quotation when data is valid", %{conn: conn} do
      conn = post(conn, Routes.quotation_path(conn, :create), quotation: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.quotation_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "author" => "some author",
               "text" => "some text"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.quotation_path(conn, :create), quotation: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update quotation" do
    setup [:create_quotation]

    test "renders quotation when data is valid", %{conn: conn, quotation: %Quotation{id: id} = quotation} do
      conn = put(conn, Routes.quotation_path(conn, :update, quotation), quotation: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.quotation_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "author" => "some updated author",
               "text" => "some updated text"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, quotation: quotation} do
      conn = put(conn, Routes.quotation_path(conn, :update, quotation), quotation: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete quotation" do
    setup [:create_quotation]

    test "deletes chosen quotation", %{conn: conn, quotation: quotation} do
      conn = delete(conn, Routes.quotation_path(conn, :delete, quotation))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.quotation_path(conn, :show, quotation))
      end
    end
  end

  defp create_quotation(_) do
    quotation = quotation_fixture()
    %{quotation: quotation}
  end
end
