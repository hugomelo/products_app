class AddParentIdToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :parent_id, :integer
  end
end
