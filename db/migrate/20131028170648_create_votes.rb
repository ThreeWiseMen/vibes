class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :idea
      t.references :user
      t.integer :kind

      t.timestamps
    end
  end
end
