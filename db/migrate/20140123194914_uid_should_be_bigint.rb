class UidShouldBeBigint < ActiveRecord::Migration
  def change
    change_table :authentications do |t|
      t.change :uid, :integer, :limit => 8
    end
  end
end
