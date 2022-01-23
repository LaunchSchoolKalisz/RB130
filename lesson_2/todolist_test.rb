require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require_relative 'todo_list'

class TodoListTest < MiniTest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  # Your tests go here. Remember they must start with "test_"
  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(@todos.size, @list.size)
  end

  def test_first
    assert_equal(@todo1, @list.first)
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    object = @list.shift
    assert_equal(@todo1, object)
    assert_equal([@todo2, @todo3], @list.to_a)
  end

  def test_pop
    object = @list.pop
    assert_equal(@todo3, object)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_done?
    assert_equal(false, @list.done?)
  end
end

=begin
LS Solutions

def test_size
  assert_equal(3, @list.size)
end

def test_first
  assert_equal(@todo1, @list.first)
end

def test_last
  assert_equal(@todo3, @list.last)
end

def test_shift
  todo = @list.shift
  assert_equal(@todo1, todo)
  assert_equal([@todo2, @todo3], @list.to_a)
end
Notice how we're using the TodoList#to_a so we can compare the lists. Note 
that had we implemented a TodoList#==, we could have compared two TodoList 
objects instead of arrays.

def test_pop
  todo = @list.pop
  assert_equal(@todo3, todo)
  assert_equal([@todo1, @todo2], @list.to_a)
end

=end