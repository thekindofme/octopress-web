class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :file_name

      t.timestamps
    end
  end
end
