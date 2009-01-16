class NewUserTable < ActiveRecord::Migration
  def self.up
    drop_table :users
    create_table "users", :force => true do |t|
      t.string   "login"
      t.string   "name"
      t.string   "email"
      t.string   "crypted_password"
      t.string   "salt"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "remember_token"
      t.datetime "remember_token_expires_at"
    end
  end

  def self.down
  end
end
