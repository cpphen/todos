defmodule Todos.FibNums do
  use GenServer

  ## Client API
  def start_link(_opts), do: GenServer.start_link(__MODULE__, %{}, name: __MODULE__)

  def get_fibs do
    GenServer.call(__MODULE__, :get_fibs)
  end

  def add_fib do
    GenServer.cast(__MODULE__, :add_fib)
  end

  def calculate(n), do: GenServer.call(__MODULE__, {:calc, n})

  ## Server Callbacks

  def init(_init_arg) do
    {:ok, {:ok, %{}}}
  end

  def handle_call({:calc, n}, _from, state) when is_integer(n) and n >= 0 do
    result = fib_tree_calculator(n)
    {:reply, result, state}
  end

  def handle_call(:get_fibs, _from, state) do
    {:reply, Enum.reverse(state), state}
  end

  def handle_cast(:add_fib, state) do
    [a, b | _] = state
    next = a + b
    {:noreply, [next | state]}
  end

  ## Server Callbacks

  defp fib_tree_calculator(0), do: 0
  defp fib_tree_calculator(1), do: 1
  defp fib_tree_calculator(n), do: fib_tree_calculator(n - 1) + fib_tree_calculator(n - 2)
end
