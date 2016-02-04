class CreateExternalSystems < ActiveRecord::Migration
  def change
    create_table :external_systems do |t|
      t.string :url
      t.text :description

      t.timestamps null: false
    end
  end
end
