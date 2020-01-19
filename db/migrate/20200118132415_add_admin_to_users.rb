class AddAdminToUsers < ActiveRecord::Migration[6.0]
  def change
    #メソッド、:モデル名、:カラム名、:型、オプション:
    add_column :users, :admin, :boolean, default: false, null: false
  end
end
