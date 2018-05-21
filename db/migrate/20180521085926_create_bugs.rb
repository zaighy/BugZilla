class CreateBugs < ActiveRecord::Migration[5.2]
  def change
    create_table :bugs do |t|
      t.string :title
      t.string :type
      t.string :status
      t.string :deadline

      t.timestamps
    end
    add_index :bugs, :title, unique: true
  end
end
