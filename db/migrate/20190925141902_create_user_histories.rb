class CreateUserHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :user_histories do |t|
      t.references :user, foreign_key: true
      t.string :action

      t.timestamps
    end
  end
end
