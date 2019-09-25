class CreateUserInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :user_infos do |t|
      t.references :user, foreign_key: true
      t.string :description
      t.string :email

      t.timestamps
    end
  end
end
