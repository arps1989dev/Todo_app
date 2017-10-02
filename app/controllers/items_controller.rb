class ItemsController < ApplicationController
  before_action :set_todo
  before_action :set_todo_item, only: [:show, :update, :destroy]


  def index
    # binding.pry
    @items = @todo.items
    json_response({
      success: true,
      data: {
        items: array_serializer.new(@items, serializer: ItemSerializer),
      }
    }, 200)
  end

  def show
    json_response(@item)
  end

  def create
    @item = @todo.items.create!(item_params)
    json_response({
      success: true,
      data: {
        item: single_record_serializer.new(@item, serializer: ItemSerializer),
      }
    }, 201)
  end

  def update
    @item.update(item_params)
    json_response({
      success: true,
      data: {
        item: single_record_serializer.new(@item, serializer: ItemSerializer),
      }
    }, 201)
  end

  def destroy
    @item.destroy
    json_response({success: true, message: "Item destroy successfully.", data: {item: @item}}, 200)
  end

  private

  def item_params
    params.require(:item).permit(:name, :done)  
  end

  def set_todo
    @todo = current_resource_owner.todos.friendly.find(params[:todo_id])
  end

  def set_todo_item
    @item = @todo.items.find_by!(id: params[:id]) if @todo
  end

end
