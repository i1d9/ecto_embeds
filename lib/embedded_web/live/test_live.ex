defmodule EmbeddedWeb.TestLive do
  use EmbeddedWeb, :live_view

  alias Embedded.Repo
  alias Embedded.Products.Product

  def mount(_, _, socket) do
    {:ok,
     socket
     |> assign(:products, Repo.all(Product))}
  end

  def render(assigns) do
    ~H"""
    <div>
      <%= for product <- @products do%>


        <div class="dropdown">
        <span><%= product.name %></span>

        <div class={if(Enum.count(product.categories, fn category -> category.selected == false end) > 0, do: "dropdown-content")}>

          <%= for unselected_category <- Enum.filter(product.categories, fn category -> category.selected == false end) do%>

          <div style="display: flex; flex-direction: row;" class="unselected_hover">
          <span


          phx-click={"select"}

          phx-value-product_id={product.id}
          phx-value-category_id={unselected_category.id}
          >
            <%= unselected_category.name %>
          </span>
        </div>
          <% end %>
        </div>

        <div style="display: flex; flex-direction: row;">
        <%= for category <- Enum.filter(product.categories, fn category -> category.selected == true end)  do%>

          <span

          style="margin: 10px; background-color: purple; padding: 10px; border-radius: 5px; color: white;"
          phx-click={"deselect"}

          phx-value-product_id={product.id}
          phx-value-category_id={category.id}
          >
            <%= category.name %>
          </span>

        <% end %>
        </div>
        </div>
      <% end %>
    </div>
    """
  end

  def handle_event("select", %{"product_id" => product_id, "category_id" => category_id}, socket) do
    product = Repo.get(Product, product_id)

    product_categories =
      product.categories
      |> Enum.map(fn category ->
        category_struct = Map.from_struct(category)

        if category.id == category_id do
          category_struct
          |> Map.update!(:selected, fn _ -> true end)
        else
          category_struct
        end
      end)

    product
    |> Ecto.Changeset.change(%{categories: product_categories})
    |> Repo.update()
    |> case do
      {:ok, _product} ->
        {:noreply, socket |> assign(:products, Repo.all(Product))}

      _ ->
        {:noreply, socket}
    end
  end

  def handle_event(
        "deselect",
        %{"product_id" => product_id, "category_id" => category_id},
        socket
      ) do
    product = Repo.get(Product, product_id)

    product_categories =
      product.categories
      |> Enum.map(fn category ->
        category_struct = Map.from_struct(category)

        if category.id == category_id do
          category_struct
          |> Map.update!(:selected, fn _ -> false end)
        else
          category_struct
        end
      end)

    product
    |> Ecto.Changeset.change(%{categories: product_categories})
    |> Repo.update()
    |> case do
      {:ok, _product} ->
        {:noreply, socket |> assign(:products, Repo.all(Product))}

      _ ->
        {:noreply, socket}
    end
  end
end
