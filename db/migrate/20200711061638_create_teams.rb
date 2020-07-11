class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.integer :user_id
      t.string :name
      t.text :body
      t.datetime :created_at
      t.datetime :updated_at
      t.string :image_id
      

      t.timestamps
    end
  end
end
