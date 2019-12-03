class User < ActiveRecord::Base

    has_many :activities
    has_many :exercises, through: :activities

    def timestamp()
        Time.now.strftime '%Y-%m-%d %H:%M:%S'
    end
    
    def calories_burnt(user_exercise, activity_duration)
        current_activity = Activity.create(:user_id => self.id, :exercise_id => user_exercise, :date => timestamp, :duration => activity_duration)
    
        current_met_value = current_activity.exercise.met_value
     
       current_activity.calories_burnt =  current_met_value * self.weight * (activity_duration/60.0).to_i
       current_activity.save
       current_activity.calories_burnt
    end

    def total_calories_burnt()
        Activity.where(user_id: self.id).sum("calories_burnt")   
    end

    def list_activities #this assumes we already know who the user is
        index=1
        array_of_activity_ids=[0]
        Activity.where(user_id: self.id).each {|activity|
        
        
            puts "#{index}. On #{activity.date} you did #{Exercise.find_by(id:activity.exercise_id).type_of_exercise} for #{activity.duration} minutes and burnt #{activity.calories_burnt.to_i}"
            array_of_activity_ids << activity.id
            index +=1
    }
    array_of_activity_ids
    end

end