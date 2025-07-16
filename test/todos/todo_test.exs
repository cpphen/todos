defmodule Todos.TodoTest do
  use Todos.DataCase

  alias Todos.Todo

  describe "tasks" do
    alias Todos.Todo.Task

    import Todos.TodoFixtures

    @invalid_attrs %{taskitem: nil}

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Todo.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Todo.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      valid_attrs = %{taskitem: "some taskitem"}

      assert {:ok, %Task{} = task} = Todo.create_task(valid_attrs)
      assert task.taskitem == "some taskitem"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todo.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      update_attrs = %{taskitem: "some updated taskitem"}

      assert {:ok, %Task{} = task} = Todo.update_task(task, update_attrs)
      assert task.taskitem == "some updated taskitem"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Todo.update_task(task, @invalid_attrs)
      assert task == Todo.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Todo.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Todo.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Todo.change_task(task)
    end
  end
end
