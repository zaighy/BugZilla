class CreateUserProjAssocs < ActiveRecord::Migration[5.2]
  def change
    create_table :user_proj_assocs do |t|
      t.references :user, foreign_key: true
      t.references :project, foreign_key: true
      t.integer :assignments

      t.timestamps
    end
  end
end
