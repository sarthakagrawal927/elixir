defmodule PheonixTestWeb.QuotationController do
  use PheonixTestWeb, :controller

  alias PheonixTest.Content
  alias PheonixTest.Content.Quotation

  action_fallback PheonixTestWeb.FallbackController

  def index(conn, _params) do
    quotations = Content.list_quotations()
    render(conn, "index.json", quotations: quotations)
  end

  def create(conn, %{"quotation" => quotation_params}) do
    with {:ok, %Quotation{} = quotation} <- Content.create_quotation(quotation_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.quotation_path(conn, :show, quotation))
      |> render("show.json", quotation: quotation)
    end
  end

  def show(conn, %{"id" => id}) do
    quotation = Content.get_quotation!(id)
    render(conn, "show.json", quotation: quotation)
  end

  def update(conn, %{"id" => id, "quotation" => quotation_params}) do
    quotation = Content.get_quotation!(id)

    with {:ok, %Quotation{} = quotation} <- Content.update_quotation(quotation, quotation_params) do
      render(conn, "show.json", quotation: quotation)
    end
  end

  def delete(conn, %{"id" => id}) do
    quotation = Content.get_quotation!(id)

    with {:ok, %Quotation{}} <- Content.delete_quotation(quotation) do
      send_resp(conn, :no_content, "")
    end
  end
end
