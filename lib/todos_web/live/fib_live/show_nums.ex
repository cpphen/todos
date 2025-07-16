defmodule TodosWeb.FibLive.ShowNums do
  use TodosWeb, :live_view
  alias Todos.FibNums

  # Use `assign` to set values to socket object
  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(fib_num_input: %{seq_num: nil}, sum: nil)

    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  @impl true
  def handle_info(:refresh, socket) do
    {:noreply, assign(socket, :fibs, FibNums.get_fibs())}
  end

  @impl true
  def handle_event("calculate", %{"seq_num" => seq_num}, socket) do
    IO.inspect(seq_num, label: "calculate Event Handler *******")

    case Integer.parse(seq_num) do
      {int, _} ->
        sum = FibNums.calculate(int)
        {:noreply, assign(socket, sum: sum)}

      :error ->
        {:noreply, assign(socket, sum: "Invalid number")}
    end

    # socket =
    #   socket
    #   |> assign(:sum, sum)

    # {:noreply, socket}
  end

  defp apply_action(socket, :fibs, _params) do
    socket
    |> assign(:fib_nums, [0, 1, 1, 2, 3])
  end
end
