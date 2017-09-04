class TodosController < ApplicationController
  before_action :set_todo, only: [:update]

  def index
    # get paginated current user todos
    @todos = current_resource_owner.todos.paginate(page: params[:page], per_page: 4)
    # json_response(@todos)
    json_response({
      success: true,
      data: {
        todos: @todos,
      }
    }, 200)
  end

  def create
    # binding.pry
    @todo = current_resource_owner.todos.create!(todo_params)
    # json_response(@todo, :created)
    json_response({
      success: true,
      data: {
        todo: @todo,
      }
    }, 201)
  end

  def show
    json_response(@todo)
  end

  def update
    @todo.update!(todo_params)
    # binding.pry
    json_response(@todo, :created)
  end

  def destroy
    @todo.destroy
    head :no_content
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :user_id)
  end

  def set_todo
    @todo = current_resource_owner.todos.find(params[:id])
  end
end
