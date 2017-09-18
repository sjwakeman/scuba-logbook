class CreateUsers < ActiveRecord::Migration
  def change
     create_table :users do |t|
       t.string :username
       t.string :password_digest	#changed password to password_digest
       t.string :email
     end
   end
 end
