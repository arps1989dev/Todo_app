class AddSlugToTodo < ActiveRecord::Migration[5.0]
  def change
    add_column :todos, :slug, :string
    add_index :todos, :slug, unique: true
  end
end
