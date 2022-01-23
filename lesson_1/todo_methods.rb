class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end

  def ==(otherTodo)
    title == otherTodo.title && 
      description == otherTodo.description &&
      done == otherTodo.done
  end
end

class TodoList
  attr_accessor :title, :todos
  
  def initialize(title)
    @title = title
    @todos = []
  end

  def add(todo)
    if todo.class == Todo
      todos.push todo
      todos
    else
      raise TypeError.new("Can only add Todo objects")
    end
  end

  def <<(todo)
    add(todo)
  end

  def size
    todos.size
  end

  def first
    todos[0]
  end

  def last 
    todos[-1]
  end

  def to_a
    todos
  end

  def done?
    return true if todos.all? {|todo| todo.done?}
    false
  end

  def item_at(idx)
    if (0...todos.size).to_a.include?(idx)
      todos[idx]
    else
      raise IndexError
    end
  end

  def mark_done_at(idx)
    item = item_at(idx)
    item.done!
  end

  def mark_undone_at(idx)
    item = item_at(idx)
    item.undone!
  end

  def done!
    (0...todos.size).to_a.each {|num| mark_done_at(num)}
  end

  def shift
    todos.shift
  end
  
  def pop
    todos.pop
  end

  def remove_at(idx)
    item = item_at(idx)
    todos.delete_at(idx)
    item
  end

  def to_s
    text = <<~HEREDOC
    "---- #{title} ----" 
    HEREDOC


    todos.each do |item| 
      text << item.to_s
      text << "\n"
    end
    text
  end

  def each
    counter = 0
    while counter < size
      yield(item_at(counter))
      counter +=1
    end
    self
  end

  def select
    new_list = TodoList.new(title)
    counter = 0

    while counter < size
      current_item = item_at(counter)
      new_list << current_item if yield(current_item)
      counter += 1
    end
    new_list
  end

  def find_by_title(search_term)
    todos.each do |todo|
      return todo if todo.title == search_term
    end
    nil
  end

  def all_done
    completed = TodoList.new(title + " - Done")

    each do |item|
      completed << item if item.done?
    end
    completed
  end

  def all_not_done
    not_completed = TodoList.new(title + " - Not Yet Done")

    each do |item|
      not_completed << item if item.done? == false
    end
    not_completed
  end
end



todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")

list = TodoList.new("Today's Todos")
list.add(todo1)
list.add(todo2)
list.add(todo3)

list.mark_done_at(1)

p list.all_not_done
