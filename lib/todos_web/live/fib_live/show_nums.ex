defmodule TodosWeb.FibLive.ShowNums do
  use TodosWeb, :live_view
  alias Todos.FibNums

  # Use `assign` to set values to socket object
  @impl true
  def mount(_params, _session, socket) do
    socket = socket
      |> assign(form: %{"seq_num" => "Initial Value"})
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
  def handle_event("calculate", %{"seq_num" => seq_num_params}, socket) do
    IO.puts "\n HERE \n"
    IO.inspect(seq_num_params)
    {:noreply, assign(socket, form: to_form(seq_num_params, as: :seq_num))}
  end

  defp apply_action(socket, :fibs, _params) do
    socket
    |> assign(:fib_nums, [0, 1, 1, 2, 3])
  end
end
