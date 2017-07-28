class TodosController < ApplicationController

  def index
    # get paginated current user todos
    @todos = current_resource_owner.todos.paginate(page: params[:page], per_page: 4)
    json_response(@todos)
  end

  def create
    # binding.pry
    @todo = current_resource_owner.todos.create!(todo_params)
    json_response(@todo, :created)
  end

  def show
    json_response(@todo)
  end

  def update
    @todo.update(todo_params)
    head :no_content
  end

  def destroy
    @todo.destroy
    head :no_content
  end

  def contact
    @contacts = request.env['omnicontacts.contacts']
    json_response(@contacts)
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :user_id)
  end

  def set_todo
    @todo = Todo.find(params[:id])
  end
end
