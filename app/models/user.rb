class User < ActiveRecord::Base

    has_many :activities
    has_many :exercises, through: :activities
    
    def calories_burnt(user_exercise, activity_duration)
        current_activity = Activity.create(:user_id => self.id, :exercise_id => user_exercise, :date => Time.now, :duration => activity_duration)
        current_met_value = current_activity.exercise.met_value
        current_activity.calories_burnt =  (current_met_value * self.weight * (activity_duration/60.0)).to_i
        current_activity.save
        current_activity.calories_burnt
    end

    def total_calories_burnt()
        Activity.where(user_id: self.id).sum("calories_burnt")   
    end

    def list_activities #this assumes we already know who the user is #populates the array of activity_id(s)
        index=1
        array_of_activity_ids=[0]
        Activity.where(user_id: self.id).each {|activity|
        array_of_activity_ids << activity.id
        index +=1
        }
        array_of_activity_ids
    end

end