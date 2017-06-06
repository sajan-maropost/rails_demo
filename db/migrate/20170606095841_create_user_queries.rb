class CreateUserQueries < ActiveRecord::Migration[5.0]
  def change
    create_table :user_queries do |t|
      t.string :name
      t.string :email
      t.string :mobile
      t.string :description

      t.timestamps
    end
  end
end
