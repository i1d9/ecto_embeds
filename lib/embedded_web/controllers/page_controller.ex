defmodule EmbeddedWeb.PageController do
  use EmbeddedWeb, :controller

  alias Embedded.Repo
  alias Embedded.Products.Product

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
