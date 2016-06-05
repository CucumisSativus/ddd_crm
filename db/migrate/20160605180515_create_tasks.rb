class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.belongs_to :user, foreign_key: true
      t.string :name
      t.text :description
      t.datetime :due_date

      t.timestamps
    end
  end
end
