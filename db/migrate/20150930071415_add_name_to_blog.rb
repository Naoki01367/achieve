class AddNameToBlog < ActiveRecord::Migration
  def change
    add_column :blogs, :name, :string
  end
end
