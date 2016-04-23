class CreateDeals < ActiveRecord::Migration[5.0]
  def change
    create_table :deals do |t|
      t.string :name
      t.text :summary
      t.decimal :amount
      t.integer :stage
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
