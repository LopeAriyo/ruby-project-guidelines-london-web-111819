class ActivityCli

    # @@current_user = nil

    def self.screen_transition 
        puts "=========="
        puts "=========="
    end

    def self.screen_one
        puts "Please choose one of the following options:"
        puts "1. Login"
        puts "2. Create New User"
        puts "3. Exit"
        input = gets.chomp.to_i

        if input < 1 || input > 3
            self.screen_one
        else
            input
        end   

        if input == 1 
            self.screen_two
        elsif input == 2
            ###### create new user
            self.screen_four
        elsif input == 3
           ### ends programme
           puts "Bye!"

           exit(true)
        end

    
    end

    def self.screen_two
        self.screen_transition
        puts "Please choose one of the following options:"
        puts "1. Enter name"
        puts "2. Go back to main menu"

        input = gets.chomp.to_i

        if input < 1 || input > 2
            self.screen_two
        else
            input
        end   

        if input == 1 
            @@current_user = self.get_user
            until @@current_user != nil
                @@current_user = self.get_user
            end
            self.screen_three
        elsif input == 2
           self.screen_one
        end
    end


    def self.screen_three
        self.screen_transition
        puts "Welcome #{@@current_user.name}!"
        puts "Please choose one of the following options:"
        puts "1. Enter a new activity"
        puts "2. Find out your total calories burned"
        puts "3. Change a previous activity"
        puts "4. Delete a previous activity"
        puts "5. Go back to main menu"
        puts "6. Exit app"
        # binding.pry

        input = gets.chomp.to_i

        if input < 1 || input > 6
            self.screen_three
        else
            input
        end  

        if input == 1
            
            user_exercise = self.get_exercise
            activity_duration = self.get_duration
            puts "Guess what #{@@current_user.name}! You burned #{@@current_user.calories_burnt(user_exercise, activity_duration)} kcal today! :) "

            self.screen_three
        elsif input == 2 

          
           puts "Congratulations #{@@current_user.name}. You've completed #{@@current_user.activities.count} activities and the total amount of calories you have burnt is #{@@current_user.total_calories_burnt.to_i} kcal"
           puts "These are your activities:"
           self.show_activities
           self.screen_three
        elsif input == 3  # this option updates
            self.show_activities
            returned_list = @@current_user.list_activities

            puts "Please select the activity you would like to update"
            update_option = gets.chomp.to_i

            until (update_option >= 1 && update_option <= (returned_list.count-1)) do
                puts "Incorrect option, Please select the activity you would like to update"
                update_option = gets.chomp.to_i
            end

            #list changeable options which is duration and type of exercise

            #method that returns current activity based on user update option
            #method that returns current duration based on user update option
        

            puts "Which attribute would you like to change."
            puts "1. Activity - the current activity is #{Activity.current_type_of_exercise(returned_list[update_option])}"
            puts "2. Duration  - the current duration for activity #{Activity.current_type_of_exercise(returned_list[update_option])} is #{Activity.current_duration(returned_list[update_option])} minutes" 

            attr_option = gets.chomp.to_i

            until (attr_option >= 1 && attr_option <= 2) do
                puts "Incorrect attribute, Please select the attribute you would like to update"
                attr_option = gets.chomp.to_i

            end

            if attr_option == 1 #this option will change the type of exercise
                puts "What would you like to change the exercise to "
                self.list_exercises

               new_exercise= gets.chomp.to_i

               until (new_exercise >= 1 && new_exercise <= Exercise.all.count) do
                puts "Incorrect option, Please select the exercise you would like to update"
                new_exercise = gets.chomp.to_i
                end

                Activity.update_exercise_id(returned_list[update_option],new_exercise)


            else # this option is automatically 2 and will change duration
                puts "What would you like to change the duration to"
                new_duration = gets.chomp.to_i
               Activity.update_activity_duration(returned_list[update_option],new_duration)

                #dont forget to update calories burnt
            end

            
           
            self.screen_three
        elsif input == 4 #this option deletes
            self.show_activities
            returned_list = @@current_user.list_activities

            puts "Please select the activity you would like to delete"
            delete_option = gets.chomp.to_i

            until (delete_option >= 1 && delete_option <= (returned_list.count-1)) do
                puts "Incorrect option, Please select the activity you would like to delete"
                delete_option = gets.chomp.to_i
            end

            puts "Are you sure you would like to delete activiy #{delete_option}. Y or N"
            sure = gets.chomp

            if sure == "Y" || sure == "y"
                Activity.delete_activity(returned_list[delete_option])
                puts "You deleted option #{delete_option}"
                puts "Here is the updated list of you activities"
                self.show_activities
                # @@current_user.list_activities
                self.screen_three
            else
                self.screen_three
            end
                
        elsif input == 5
           self.screen_one
        elsif input == 6
            puts "Bye #{@@current_user.name}!"

           exit(true)
        end
    end

    def self.screen_four # this screen creates a new user
        puts "Please enter your name:"
        name = gets.chomp
        puts "Please enter your surname:"
        surname = gets.chomp
        puts "Please enter your height in cm:"
        height = gets.chomp.to_i
        puts "Please enter your weight in kg:"
        weight = gets.chomp.to_i
        puts "Please enter your age"
        age = gets.chomp.to_i
        puts "Please enter your gender"
        gender = gets.chomp

        User.create(name: name, surname: surname, height: height, weight: weight, age: age, gender: gender)
    
        self.screen_one
    end

    def self.get_user
        puts "Please enter your name"
        name= gets.chomp
        if !User.find_by(name: name)
            puts "Bye bye, you're not welcome"
            user = nil
            return user
        end
        User.find_by(name: name)
    end

    @@say_message = true

    def self.get_exercise
        if @@say_message 
            puts "Well done for tracking your activity #{@@current_user.name}! Please choose the number of the exercise you did today."
        end
        self.list_exercises
        user_exercise= gets.chomp.to_i
        if user_exercise < 1 || user_exercise > Exercise.all.count
            @@say_message = false
            self.get_exercise
        else
            user_exercise
        end 
    end

    def self.get_duration
        puts "How long was your activity?"
        activity_duration = gets.chomp.to_i
    end

    def self.show_activities
        index = 1
        Activity.where(user_id:@@current_user.id).each{|activity|
        puts "#{index}. On #{activity.date.to_formatted_s(:long_ordinal)} YOU did #{activity.exercise.type_of_exercise} for #{activity.duration} minutes and burnt #{activity.calories_burnt.to_i}"
        index +=1
        }
    end

    def self.list_exercises 
        Exercise.all.each {|exercise|
            puts "#{exercise.id}. #{exercise.type_of_exercise} "
        }
   end

end