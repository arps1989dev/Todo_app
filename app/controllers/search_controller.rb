class SearchController < ApplicationController
  def search
    if params[:q].nil?
      @todos = []
    else
      @todos = Todo.search params[:q]
    end
  end
end
