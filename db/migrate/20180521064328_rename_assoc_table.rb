class RenameAssocTable < ActiveRecord::Migration[5.2]
  def change
    rename_table :user_proj_assocs, :projects_users
  end
end
