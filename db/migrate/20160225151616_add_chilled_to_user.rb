class AddChilledToUser < ActiveRecord::Migration
  def change
    add_column :users, :chilled, :boolean
  end
end
