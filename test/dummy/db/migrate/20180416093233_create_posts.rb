class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :slug
      t.references :user, foreign_key: true

      t.timestamps
    end

    add_index :posts, [:user_id, :slug], unique: true
  end
end
