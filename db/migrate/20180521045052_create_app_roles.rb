class CreateAppRoles < ActiveRecord::Migration[5.2]
  def up
    ['Developer', 'Manager', 'QA'].each do |role_name|
      Role.create! name: role_name
    end
  end
  def down
    Role.where(name: ['Developer', 'Manager', 'QA']).destroy_all
  end
end
