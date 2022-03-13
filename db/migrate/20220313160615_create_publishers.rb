class CreatePublishers < ActiveRecord::Migration[6.0]
  def change
    create_table :publishers do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :description

      t.timestamps
    end
  end
end
