class CreateDives < ActiveRecord::Migration
  def change
     create_table :dives do |t|
       t.integer :dive_number
       t.string :date
       t.string :location
       t.string :visability
       t.string :bottom_time_to_date
       t.string :bottom_time_this_dive
       t.string :accumulated_time
       t.string :dive_start
       t.string :dive_end
       t.string :dive_comments
       t.integer :user_id
     end
   end
 end
