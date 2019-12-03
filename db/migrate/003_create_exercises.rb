class CreateExercises < ActiveRecord::Migration[4.2]
    def change
        create_table :exercises do |t|
            t.string :type_of_exercise
            t.float :met_value 
            t.integer :estimate_calories_burnt_per_unit 
        end
    end
  end
