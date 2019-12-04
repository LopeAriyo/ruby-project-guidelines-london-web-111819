
puts 'starting'
10.times do
    User.create(name: Faker::Name.first_name, surname: Faker::Name.last_name, height: Faker::Number.between(from: 140, to: 190), :weight => Faker::Number.between(from: 50, to: 100), :age => Faker::Number.between(from: 18, to: 100), :gender => Faker::Gender.binary_type)
end
puts 'users seeded'
Exercise.create( :type_of_exercise => "Swimming",  :met_value => 9.8, :estimate_calories_burnt_per_unit => 100)
Exercise.create( :type_of_exercise => "Running",  :met_value => 8.0, :estimate_calories_burnt_per_unit => 80)
Exercise.create( :type_of_exercise => "Yoga",  :met_value => 4.0, :estimate_calories_burnt_per_unit => 20)
puts 'exercises seeded'
50.times do
    Activity.create( :date => Time.now, :duration => Faker::Number.within(range: 1..60), :calories_burnt => Faker::Number.within(range: 1..500) ,user_id:User.all.sample.id, exercise_id: Exercise.all.sample.id)
end
puts 'finished'

# binding.pry