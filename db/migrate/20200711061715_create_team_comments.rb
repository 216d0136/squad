class CreateTeamComments < ActiveRecord::Migration[5.2]
  def change
    create_table :team_comments do |t|
      t.string :comment
      t.references :user, foreign_key: true
      t.references :team, foreign_key: true

      t.timestamps
    end
  end
end
