class UpdateCritDim < ActiveRecord::Migration
  def change
    change_table(:crit_dim) do |t|
      t.column :is_visible_in_list, :integer, default: 0
      t.column :is_critical_dimension, :integer, default: 1
    end
  end
end
