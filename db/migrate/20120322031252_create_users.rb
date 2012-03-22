class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :mobile
      t.string :phone
      t.string :twitter
      t.string :facebook
      t.string :profile_picture

      t.timestamps
    end
  end
end
