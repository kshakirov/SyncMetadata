class ChangeExtSystemsParts < ActiveRecord::Migration
  def change
    change_table(:external_systems) do |t|
      t.column :part_last,  :integer, default: 0
    end
  end
end
