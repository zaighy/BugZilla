class RemoveAssignmentsFromuserProjAssoc < ActiveRecord::Migration[5.2]
  def change
    remove_column :user_proj_assocs, :assignments
  end
end
