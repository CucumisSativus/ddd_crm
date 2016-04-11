class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
