class CreateDives < ActiveRecord::Migration
  def change
     create_table :dives do |t|
       t.integer :dive_number
       t.string :date
       t.string :location
       t.string :visability
       t.integer :bottom_time_to_date
       t.integer :bottom_time_this_dive
       t.integer :accumulated_time
       t.integer :dive_start
       t.integer :dive_end
       t.text :dive_comments
     end
   end
 end
