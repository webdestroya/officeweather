class CreateTempReadings < ActiveRecord::Migration
  def change
    create_table :temp_readings do |t|
      t.float :temperature, :null => :false

      t.timestamps
    end

    add_index :temp_readings, :created_at

  end
end
