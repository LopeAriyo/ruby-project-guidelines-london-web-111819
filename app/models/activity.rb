class Activity < ActiveRecord::Base

    belongs_to :user
    belongs_to :exercise
     
 def self.delete_activity(id)
    Activity.find_by(id:id).destroy
 end

 def self.current_type_of_exercise(id)
    Exercise.find_by(id:Activity.find_by(id:id).exercise_id).type_of_exercise
 end

 def self.current_duration(id)
    Activity.find_by(id:id).duration

 end

 def self.update_calories_burnt_for_exercise(id,new_id)
   current_activity = Activity.find_by(id:id)
   current_met_value = Exercise.find_by(id:new_id).met_value
   current_user = User.find_by(id:current_activity.user_id)
   current_activity.calories_burnt =  (current_met_value * current_user.weight * (current_activity.duration/60.0)).to_i
end

 def self.update_exercise_id (id, new_id)
   to_be_updated = Activity.find_by(id:id)
   to_be_updated.exercise_id = new_id
   to_be_updated.calories_burnt = self.update_calories_burnt_for_exercise(id, new_id)
   to_be_updated.save
end

def self.update_calories_burnt_for_duration(id,new_duration)
     current_activity = Activity.find_by(id:id)
     current_met_value = current_activity.exercise.met_value
     current_user = User.find_by(id:current_activity.user_id)
    current_activity.calories_burnt =  (current_met_value * current_user.weight * (new_duration/60.0)).to_i
 end
 
def self.update_activity_duration(id,new_duration)
   to_be_updated = Activity.find_by(id:id)
   to_be_updated.duration = new_duration
   to_be_updated.calories_burnt = self.update_calories_burnt_for_duration(id, new_duration)
  
   to_be_updated.save
end

end