defmodule Todos.TodoFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Todos.Todo` context.
  """

  @doc """
  Generate a task.
  """
  def task_fixture(attrs \\ %{}) do
    {:ok, task} =
      attrs
      |> Enum.into(%{
        taskitem: "some taskitem"
      })
      |> Todos.Todo.create_task()

    task
  end
end
