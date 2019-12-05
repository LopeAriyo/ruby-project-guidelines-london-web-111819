require_relative "spec_helper"
require_relative "../config/environment"

describe User do 
    it "new user can be added" do 
        User.destroy(User.find_or_create_by(name: "Lope Dummy").id)
        User.create(name: "Lope Dummy", surname: "Ariyo", height: 149, weight: 52, age: 28, gender: "Female")
        expect(User.find_by(name: "Lope Dummy").name).to eq("Lope Dummy")
    end
end

describe Exercise do 
    it "new exercise can be added" do 
        Exercise.destroy(Exercise.find_or_create_by(type_of_exercise: "Exercise Dummy").id)
        Exercise.create(type_of_exercise: "Exercise Dummy", met_value: 12.0, estimate_calories_burnt_per_unit:nil )
        expect(Exercise.find_by(type_of_exercise: "Exercise Dummy").type_of_exercise).to eq("Exercise Dummy")
    end
end

describe Activity do 
    it "new activity can be added" do 
       my_exercise = Exercise.find_by(type_of_exercise: "Exercise Dummy")
       my_user = User.find_by(name: "Lope Dummy")
       activity_duration = 60
       my_burnt_calories = (my_exercise.met_value * my_user.weight * (activity_duration/60.0)).to_i
        my_activity = Activity.create(user_id: my_user.id, exercise_id: my_exercise.id, date: Time.now, duration: activity_duration, calories_burnt: my_burnt_calories )
        expect(Activity.find_by(exercise_id: my_exercise.id).duration).to eq(60)

        Activity.destroy(my_activity.id)
        Exercise.destroy(my_exercise.id)
        User.destroy(my_user.id)
    end
end