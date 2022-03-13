class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.datetime :when_at
      t.integer :pet_id

      t.timestamps
    end
  end
end
