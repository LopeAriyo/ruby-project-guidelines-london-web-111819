class CreateActivities < ActiveRecord::Migration[4.2]
    def change
        create_table :activities do |t|
            t.integer :user_id
            t.integer :exercise_id
            t.datetime :date
            t.integer :duration #minutes
            t.float :calories_burnt 
        end
    end
  end
