class TodosController < ApplicationController
  before_action :set_todo, only: [:update, :destroy, :show]

  def index
    # get paginated current user todos
    # @todos = current_resource_owner.todos.paginate(page: params[:page], per_page: 4)
    @todos = current_resource_owner.todos
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
    # binding.pry
    json_response({
      success: true,
      data: {
        todo: single_record_serializer.new(@todo, serializer: SingleTodoSerializer),
      }
    }, 200)
  end

  def update
    # binding.pry
    @todo.update_attributes!(todo_params)
    # json_response(@todo, :created)
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
    @todo = Todo.friendly.find(params[:id])
  end
end
