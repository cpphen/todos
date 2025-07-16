defmodule Todos.FibNums do
  use GenServer

  ## Client API

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def get_fibs do
    GenServer.call(__MODULE__, :get_fibs)
  end

  def add_fib do
    GenServer.cast(__MODULE__, :add_fib)
  end

  ## Server Callbacks

  def init(_init_arg) do
    {:ok, [0, 1]}
  end

  def handle_call(:get_fibs, _from, state) do
    {:reply, Enum.reverse(state), state}
  end

  def handle_cast(:add_fib, state) do
    [a, b | _] = state
    next = a + b
    {:noreply, [next | state]}
  end
end
