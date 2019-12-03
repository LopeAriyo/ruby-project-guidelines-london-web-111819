class CreateUsers < ActiveRecord::Migration[4.2]
    def change
        create_table :users do |t|
            t.string :name
            t.string :surname
            t.integer :height #cm
            t.integer :weight #kg
            t.integer :age
            t.string :gender
        end
    end
  end

