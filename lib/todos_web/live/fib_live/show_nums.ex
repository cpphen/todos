defmodule TodosWeb.FibLive.ShowNums do
  use TodosWeb, :live_view
  alias Todos.FibNums

  @impl true
  def mount(_params, _session, socket) do
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

  defp apply_action(socket, :fibs, _params) do
    socket
    |> assign(:fib_nums, [0, 1, 1, 2, 3])
  end
end
