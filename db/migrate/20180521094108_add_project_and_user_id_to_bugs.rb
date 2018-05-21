class AddProjectAndUserIdToBugs < ActiveRecord::Migration[5.2]
  def change
    add_column :bugs, :project_id, :reference
    add_column :bugs, :user_id, :reference
  end
end
