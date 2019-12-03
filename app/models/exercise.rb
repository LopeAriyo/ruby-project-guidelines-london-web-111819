class Exercise < ActiveRecord::Base

    has_many :activities
    has_many :users, through: :activities

   def self.list_exercises 
        self.all.each {|exercise|
            puts "#{exercise.id}. #{exercise.type_of_exercise} "
    }
   end

end