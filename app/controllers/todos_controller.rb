class TodosController < ApplicationController
  before_action :set_todo, only: [:update, :destroy]

  def index
    @todos = current_resource_owner.todos
    json_response({
      success: true,
      data: {
        todos: @todos,
      }
    }, 200)
  end

  def create
    @todo = current_resource_owner.todos.create!(todo_params)
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
    @todo.update_attributes!(todo_params)
    json_response({ success: true, data: {todo: @todo} }, 201)
  end

  def destroy
    @todo.destroy!
    json_response({success: true, message: "Todo destroy successfully.", data: {todo: @todo}}, 200)
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :user_id)
  end

  def set_todo
    @todo = current_resource_owner.todos.find(params[:id])
  end
end
