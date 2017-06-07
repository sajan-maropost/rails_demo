class AddNameToMyImage < ActiveRecord::Migration[5.0]
  def change
    add_column :my_images, :name, :string
  end
end
