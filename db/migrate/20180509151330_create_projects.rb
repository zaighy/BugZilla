class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
