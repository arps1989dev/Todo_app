class TodosController < ApplicationController
  before_action :set_todo, only: [:update]
  skip_before_action :doorkeeper_authorize!


  def index
    # get paginated current user todos
    @todos = Todo.paginate(page: params[:page], per_page: 4)
    json_response(@todos)
  end

  def create
    # binding.pry
    @todo = Todo.create!(todo_params)
    json_response(@todo, :created)
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

  # def set_todo
  #   @todo = current_resource_owner.todos.find(params[:id])
  # end
end
